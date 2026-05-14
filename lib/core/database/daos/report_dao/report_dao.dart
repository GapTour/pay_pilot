import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/data/params/report_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/collect_report_events.dart';
import 'package:pay_pilot/core/database/tables/event_ratios.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/report_details/data/models/response_report_details.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

part 'report_dao.g.dart';

@DriftAccessor(
  tables: [
    Events,
    Ratios,
    Members,
    Teams,
    Reports,
    CollectReportEvents,
    EventTransactions,
    EventRatios,
  ],
)
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(super.db);

  Future<ResponseReportDetails> getFullReportDetailsWithoutBalance(
    int reportID,
  ) async {
    final eventDetails = await _collectTotalResponseEvents(reportID);

    final rawReport = await (db.select(
      db.reports,
    )..where((tbl) => tbl.id.equals(reportID))).getSingle();

    return ResponseReportDetails(
      id: rawReport.id,
      title: rawReport.title,
      version: rawReport.version,
      generateFor: rawReport.generateFor,
      events: eventDetails,
      description: rawReport.description,
    );
  }

  Future<FullReportViewModel> getFullReportDetails(int reportID) async {
    final membersBalance = await _collectTotalBalance(reportID);
    final eventDetails = await _collectTotalEvents(reportID);

    final rawReport = await (db.select(
      db.reports,
    )..where((tbl) => tbl.id.equals(reportID))).getSingle();

    return FullReportViewModel(
      id: rawReport.id,
      title: rawReport.title,
      version: rawReport.version,
      generateFor: rawReport.generateFor,
      events: eventDetails,
      membersBalance: membersBalance,
    );
  }

  Future<List<BalanceModel>> _collectTotalBalance(int reportID) async {
    final query =
        (select(
          db.collectReportEvents,
        )..where((tbl) => tbl.reportID.equals(reportID))).join([
          innerJoin(events, events.id.equalsExp(collectReportEvents.eventID)),
        ]);
    final rows = await query.get();
    final List<RawEventDetailsModel> eventDetails = [];
    final teamsInfo = await db.select(db.teams).get();

    for (var eventRow in rows) {
      final List<EventTransaction> rawTransactions =
          await (select(eventTransactions)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .get();

      final ratioQuery =
          (select(eventRatios)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .join([
                innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
              ]);
      final rawRatios = await ratioQuery.get();
      final List<MemberRatioModel> memberRatios = [
        ...rawRatios.map((e) {
          return MemberRatioModel(
            id: e.readTable(eventRatios).id,
            ratio: e.readTable(eventRatios).ratio,
            member: e.readTable(members),
          );
        }),
      ];

      if (memberRatios.isEmpty) {
        memberRatios.addAll(
          await _fetchMemberRatioFromTeamInfo(
            eventRow.readTable(events).teamID,
          ),
        );
      }

      final List<TransactionModel> transactions = rawTransactions.map((e) {
        return TransactionModel(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
          attachment: e.attachment,
          paidByGuest: e.guestID,
          paidByMember: e.memberID,
        );
      }).toList();

      eventDetails.add(
        RawEventDetailsModel(
          id: eventRow.readTable(events).id,
          transactions: transactions,
          team: teamsInfo.firstWhere(
            (element) => element.id == eventRow.readTable(events).teamID,
          ),
          memberRatios: memberRatios,
        ),
      );
    }
    final membersBalance = await CalculatorHelper.salaries(
      eventDetails: eventDetails,
    );
    membersBalance.sort((a, b) => b.totalBalance.compareTo(a.totalBalance));

    return membersBalance;
  }

  Future<List<MemberRatioModel>> _fetchMemberRatioFromTeamInfo(
    int teamID,
  ) async {
    final teamQuery = (select(teams)..where((tbl) => tbl.id.equals(teamID)))
        .join([innerJoin(ratios, ratios.teamID.equals(teamID))]);
    final rawTeamRatios = await teamQuery.get();
    final List<MemberRatioModel> memberRatios = [];

    for (var row in rawTeamRatios) {
      final Member memberInfo =
          await (select(members)
                ..where((tbl) => tbl.id.equals(row.readTable(ratios).memberID)))
              .getSingle();

      memberRatios.add(
        MemberRatioModel(
          id: row.readTable(ratios).id,
          ratio: row.readTable(ratios).ratio,
          member: memberInfo,
        ),
      );
    }

    return memberRatios;
  }

  Future<List<EventDetailsModel>> _collectTotalEvents(int reportID) async {
    final query =
        (select(
          db.collectReportEvents,
        )..where((tbl) => tbl.reportID.equals(reportID))).join([
          innerJoin(events, events.id.equalsExp(collectReportEvents.eventID)),
        ]);
    final rows = await query.get();
    final List<EventDetailsModel> eventDetails = [];
    final teamsInfo = await db.select(db.teams).get();

    for (var eventRow in rows) {
      final List<EventTransaction> rawTransactions =
          await (select(eventTransactions)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .get();

      final ratioQuery = select(
        eventRatios,
      ).join([innerJoin(members, members.id.equalsExp(eventRatios.memberID))]);
      final rawRatios = await ratioQuery.get();

      final List<TransactionModel> transactions = rawTransactions.map((e) {
        return TransactionModel(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
          attachment: e.attachment,
          paidByGuest: e.guestID,
          paidByMember: e.memberID,
        );
      }).toList();

      final membersBalance = await CalculatorHelper.eventSalary(
        eventDetails: RawEventDetailsModel(
          id: eventRow.readTable(events).id,
          transactions: transactions,
          team: teamsInfo.firstWhere(
            (element) => element.id == eventRow.readTable(events).teamID,
          ),
          memberRatios: rawRatios.map((e) {
            return MemberRatioModel(
              id: e.readTable(eventRatios).id,
              ratio: e.readTable(eventRatios).ratio,
              member: e.readTable(members),
            );
          }).toList(),
        ),
      );

      eventDetails.add(
        EventDetailsModel(
          id: eventRow.readTable(events).id,
          transactions: transactions,
          team: teamsInfo.firstWhere(
            (element) => element.id == eventRow.readTable(events).teamID,
          ),
          memberRatios: rawRatios.map((e) {
            return MemberRatioModel(
              id: e.readTable(eventRatios).id,
              ratio: e.readTable(eventRatios).ratio,
              member: e.readTable(members),
            );
          }).toList(),
          membersBalance: membersBalance,
          date: eventRow.readTable(events).date,
          title: eventRow.readTable(events).title,
          description: eventRow.readTable(events).description,
        ),
      );
    }

    return eventDetails;
  }

  Future<List<ResponseEventDetails>> _collectTotalResponseEvents(
    int reportID,
  ) async {
    final query =
        (select(
          db.collectReportEvents,
        )..where((tbl) => tbl.reportID.equals(reportID))).join([
          innerJoin(events, events.id.equalsExp(collectReportEvents.eventID)),
        ]);
    final rows = await query.get();
    final List<ResponseEventDetails> eventDetails = [];
    final teamsInfo = await db.select(db.teams).get();

    for (var eventRow in rows) {
      final List<EventTransaction> rawTransactions =
          await (select(eventTransactions)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .get();

      final ratioQuery =
          (select(eventRatios)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .join([
                innerJoin(members, members.id.equalsExp(eventRatios.memberID)),
              ]);
      final rawRatios = await ratioQuery.get();

      final List<TransactionModel> transactions = rawTransactions.map((e) {
        return TransactionModel(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
          attachment: e.attachment,
          paidByGuest: e.guestID,
          paidByMember: e.memberID,
        );
      }).toList();

      eventDetails.add(
        ResponseEventDetails(
          id: eventRow.readTable(events).id,
          transactions: transactions
              .map(ResponseEventTransaction.fromDb)
              .toList(),
          team: ResponseTeam.fromDb(
            teamsInfo.firstWhere(
              (element) => element.id == eventRow.readTable(events).teamID,
            ),
          ),
          memberRatios: rawRatios.map((e) {
            return ResponseEventRatio(
              id: e.readTable(eventRatios).id,
              ratio: e.readTable(eventRatios).ratio,
              memberID: e.readTable(members).id,
            );
          }).toList(),
          date: eventRow.readTable(events).date,
          title: eventRow.readTable(events).title,
          description: eventRow.readTable(events).description,
          orders: [],
        ),
      );
    }

    return eventDetails;
  }

  Future<Report> insertReport(ReportParams report) async {
    final reports =
        await (db.select(db.reports)..where(
              (tbl) =>
                  tbl.generateFor.year.equals(report.generateFor.year) &
                  tbl.generateFor.month.equals(report.generateFor.month),
            ))
            .get();

    final reportID = await db
        .into(db.reports)
        .insert(
          ReportsCompanion(
            title: Value(report.title),
            version: Value(reports.length + 1),
            description: Value(report.description),
            generateFor: Value(report.generateFor),
          ),
        );

    for (var event in report.events) {
      await db
          .into(db.collectReportEvents)
          .insert(
            CollectReportEventsCompanion(
              reportID: Value(reportID),
              eventID: Value(event),
            ),
          );
    }

    final createdReport = await (db.select(
      db.reports,
    )..where((tbl) => tbl.id.equals(reportID))).getSingle();

    return createdReport;
  }

  Future<List<Report>> getAllReports() async {
    return await (db.select(
      db.reports,
    )..where((tbl) => tbl.isActive.equals(true))).get();
  }

  // Future<void> updateReport(ReportForm report) async {
  //   await (db.update(
  //     db.reports,
  //   )..where((tbl) => tbl.id.equals(report.id!))).write(
  //     ReportsCompanion(
  //       title: Value(report.title),
  //       version: Value(report.version),
  //       description: Value(report.description),
  //       totalBalance: Value(report.totalBalance),
  //       generateFor: Value(report.generateFor),
  //     ),
  //   );

  //   for (var event in report.events) {
  //     await (db.update(db.collectReportEvents)..where(
  //           (tbl) =>
  //               tbl.eventID.equals(event.id) & tbl.reportID.equals(report.id!),
  //         ))
  //         .write(
  //           CollectReportEventsCompanion(
  //             reportID: Value(reportID),
  //             eventID: Value(event.id),
  //           ),
  //         );
  //   }
  // }

  Future<void> deleteReport(int id) async {
    await (db.delete(db.reports)..where((tbl) => tbl.id.equals(id))).go();
  }
}
