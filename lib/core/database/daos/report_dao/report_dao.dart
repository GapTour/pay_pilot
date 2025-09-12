import 'package:drift/drift.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/tables/collect_report_events.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/database/tables/events.dart';
import 'package:pay_pilot/core/database/tables/members.dart';
import 'package:pay_pilot/core/database/tables/ratios.dart';
import 'package:pay_pilot/core/database/tables/reports.dart';
import 'package:pay_pilot/core/database/tables/teams.dart';
import 'package:pay_pilot/core/utils/helpers/calculator_helper.dart';
import 'package:pay_pilot/features/reports/data/report_form.dart';

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
  ],
)
class ReportDao extends DatabaseAccessor<AppDatabase> with _$ReportDaoMixin {
  ReportDao(super.db);

  Future<FullReportViewModel> getFullReportDetails(int reportID) async {
    final eventDetailsQuery =
        (select(
          db.collectReportEvents,
        )..where((tbl) => tbl.reportID.equals(reportID))).join([
          innerJoin(events, events.id.equalsExp(collectReportEvents.eventID)),
        ]);
    final eventDetailsRow = await eventDetailsQuery.get();
    final teamsInfo = await db.select(db.teams).get();
    final List<EventDetailsModel> eventDetails = [];

    for (var eventRow in eventDetailsRow) {
      final List<EventTransaction> rawTransactions =
          await (select(eventTransactions)..where(
                (tbl) => tbl.eventID.equals(eventRow.readTable(events).id),
              ))
              .get();

      final List<Transactions> transactions = rawTransactions.map((e) {
        return Transactions(
          id: e.id,
          description: e.description,
          amount: e.amount,
          transactionType: e.transactionType,
          date: e.date,
        );
      }).toList();

      eventDetails.add(
        EventDetailsModel(
          id: eventRow.readTable(events).id,
          title: eventRow.readTable(events).title,
          description: eventRow.readTable(events).description,
          date: eventRow.readTable(events).date,
          transactions: transactions,
          team: teamsInfo.firstWhere(
            (element) => element.id == eventRow.readTable(events).teamID,
          ),
        ),
      );
    }

    final List<TeamMemberDetailsModel> teamMemberDetails = [];
    for (var t in eventDetails) {
      final teamMembersQuery =
          (select(ratios)..where((tbl) => tbl.teamID.equals(t.team.id))).join([
            innerJoin(members, members.id.equalsExp(ratios.memberID)),
            innerJoin(teams, teams.id.equalsExp(ratios.teamID)),
          ]);

      final teamMembersRow = await teamMembersQuery.get();

      final fetchedTeamMembers = teamMembersRow.map((row) {
        return TeamMemberDetailsModel(
          id: row.readTable(ratios).id,
          ratio: row.readTable(ratios).ratio,
          member: row.readTable(members),
          team: row.readTable(teams),
        );
      }).toList();

      teamMemberDetails.addAll(fetchedTeamMembers);
    }

    final membersBalance = await CalculatorHelper.salaries(
      teamMemberDetails: teamMemberDetails,
      eventDetails: eventDetails,
    );

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

  Future<int> insertReport(ReportForm report) async {
    final reportID = await db
        .into(db.reports)
        .insert(
          ReportsCompanion(
            title: Value(report.title),
            version: Value(report.version),
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
              eventID: Value(event.id),
            ),
          );
    }

    return reportID;
  }

  Future<List<Report>> getAllReports() async {
    return await db.select(db.reports).get();
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
