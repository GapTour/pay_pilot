import 'package:collection/collection.dart';
import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';

class CalculatorHelper {
  static Future<List<BalanceModel>> salaries({
    required List<RawEventDetailsModel> eventDetails,
  }) async {
    final List<BalanceModel> membersBalance = [];

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

      final deduplicateMembers = detail.memberRatios
          .fold<List<MemberRatioModel>>([], (acc, element) {
            if (!acc.any((existing) => existing.id == element.id)) {
              acc.add(element);
            }
            return acc;
          });

      for (var item in deduplicateMembers) {
        final double balance = totalBalance * (item.ratio / 100);
        final checkMember = membersBalance.firstWhereOrNull(
          (e) => e.member.id == item.member.id,
        );

        if (checkMember != null) {
          membersBalance
            ..remove(checkMember)
            ..add(
              BalanceModel(
                member: item.member,
                totalBalance: balance + checkMember.totalBalance,
              ),
            );
        }
        if (checkMember == null) {
          membersBalance.add(
            BalanceModel(member: item.member, totalBalance: balance),
          );
        }
      }
    }
    // Duration totalDuration = await compute(_calculateDurationFrom, args);
    return membersBalance;
  }

  static Future<List<BalanceModel>> eventSalary({
    required RawEventDetailsModel eventDetails,
  }) async {
    final List<BalanceModel> membersBalance = [];

    double totalBalance = eventDetails.transactions.fold(0, (
      previousValue,
      element,
    ) {
      if (element.transactionType == TransactionType.expense) {
        return previousValue - element.amount;
      }
      return previousValue + element.amount;
    });

    if (totalBalance < 1) totalBalance = 0;

    for (var item in eventDetails.memberRatios) {
      final double balance = totalBalance * (item.ratio / 100);
      final checkMember = membersBalance.firstWhereOrNull(
        (e) => e.member.id == item.member.id,
      );

      if (checkMember != null) {
        membersBalance
          ..remove(checkMember)
          ..add(
            BalanceModel(
              member: item.member,
              totalBalance: balance + checkMember.totalBalance,
            ),
          );
      }
      if (checkMember == null) {
        membersBalance.add(
          BalanceModel(member: item.member, totalBalance: balance),
        );
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
