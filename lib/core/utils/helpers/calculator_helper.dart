import 'package:collection/collection.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/full_report_details_model.dart';
import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class CalculatorHelper {
  static Future<List<MembersBalance>> salaries({
    required List<TeamMemberDetailsModel> teamMemberDetails,
    required List<EventDetailsModel> eventDetails,
  }) async {
    final List<MembersBalance> membersBalance = [];

    for (var detail in eventDetails) {
      final double totalBalance = detail.transactions.fold(0, (
        previousValue,
        element,
      ) {
        if (element.transactionType == TransactionType.expense) {
          return previousValue - element.amount;
        }
        return previousValue + element.amount;
      });
      if (totalBalance < 1) continue;

      final members = teamMemberDetails.where(
        (element) => element.team.id == detail.team.id,
      );

      for (var item in members) {
        final double balance = totalBalance * (item.ratio / 100);
        final checkMember = membersBalance.firstWhereOrNull(
          (e) => e.member.id == item.member.id,
        );
        if (checkMember != null) {
          membersBalance
            ..remove(checkMember)
            ..add(
              MembersBalance(
                member: item.member,
                totalBalance: balance + checkMember.totalBalance,
              ),
            );
        }
        if (checkMember == null) {
          membersBalance.add(
            MembersBalance(member: item.member, totalBalance: balance),
          );
        }
      }
    }
    // Duration totalDuration = await compute(_calculateDurationFrom, args);
    return membersBalance;
  }
}

// Duration _calculateDurationFrom((List<TimeEntry>, int) args) {
//   final timeEntries = args.$1;
//   final projectID = args.$2;
//   final listedEntries = timeEntries
//       .where((timeEntry) => timeEntry.projectId == projectID)
//       .toList();

//   Duration totalDuration = Duration.zero;
//   for (var timeEntry in listedEntries) {
//     totalDuration += timeEntry.duration != null
//         ? Duration(seconds: (timeEntry.duration! * 3600).round())
//         : Duration.zero;
//   }

//   return totalDuration;
// }
