import 'package:collection/collection.dart';
import 'package:pay_pilot/core/data/enums/transaction_status.dart';
import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/data/models/raw_event_details_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_balance.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

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

  static double calculateTotalAmount({
    required List<ResponseEventTransaction> transactions,
  }) {
    return transactions.fold(0, (previousValue, element) {
      if (element.transactionType.isExpense) {
        return previousValue - element.amount;
      }
      return previousValue + element.amount;
    });
  }

  static Future<List<ResponseEventBalance>> customEventSalary({
    required double totalAmount,
    required List<ResponseEventTransaction> transactions,
    required List<ResponseMember> members,
    required List<ResponseEventRatio> memberRatios,
  }) async {
    final List<ResponseEventBalance> membersBalance = [];
    double totalExpense = 0;

    if (totalAmount < 1) totalAmount = 0;

    for (var item in memberRatios) {
      final involvedMember = members.firstWhere(
        (element) => element.id == item.memberID,
      );

      final double balance = totalAmount * (item.ratio / 100);
      final memberBalanceInfo = membersBalance.firstWhereOrNull(
        (e) => e.member.id == item.memberID,
      );

      totalExpense = transactions
          .where((transaction) {
            return transaction.transactionType.isExpense &&
                transaction.paidByMember == item.memberID;
          })
          .toList()
          .fold(0, (previousValue, element) {
            return previousValue + element.amount;
          });

      if (memberBalanceInfo != null) {
        membersBalance
          ..remove(memberBalanceInfo)
          ..add(
            ResponseEventBalance(
              member: involvedMember,
              expenses: totalExpense,
              salary: balance + memberBalanceInfo.salary,
            ),
          );
      }
      if (memberBalanceInfo == null) {
        membersBalance.add(
          ResponseEventBalance(
            member: involvedMember,
            expenses: totalExpense,
            salary: balance,
          ),
        );
      }
    }

    // Duration totalDuration = await compute(_calculateDurationFrom, args);
    return membersBalance;
  }

  static Future<List<ResponseEventBalance>> customTotalSalaries({
    required List<ResponseEventDetails> events,
    required List<ResponseMember> members,
  }) async {
    final List<ResponseEventBalance> membersBalance = [];

    for (var eventDetail in events) {
      final double totalBalance = eventDetail.transactions.fold(0, (
        previousValue,
        element,
      ) {
        if (element.transactionType == TransactionStatus.expense) {
          return previousValue - element.amount;
        }
        return previousValue + element.amount;
      });

      if (totalBalance < 1) continue;

      for (var ratioInfo in eventDetail.memberRatios) {
        final involvedMember = members.firstWhere(
          (element) => element.id == ratioInfo.memberID,
        );

        final double balance = totalBalance * (ratioInfo.ratio / 100);
        final memberBalanceInfo = membersBalance.firstWhereOrNull(
          (e) => e.member.id == ratioInfo.memberID,
        );

        final totalExpense = eventDetail.transactions
            .where((transaction) {
              return transaction.transactionType.isExpense &&
                  transaction.paidByMember == ratioInfo.memberID;
            })
            .toList()
            .fold(0.0, (previousValue, element) {
              return previousValue + element.amount;
            });

        if (memberBalanceInfo != null) {
          membersBalance
            ..remove(memberBalanceInfo)
            ..add(
              ResponseEventBalance(
                member: involvedMember,
                expenses: totalExpense,
                salary: balance + memberBalanceInfo.salary,
              ),
            );
        }
        if (memberBalanceInfo == null) {
          membersBalance.add(
            ResponseEventBalance(
              member: involvedMember,
              expenses: totalExpense,
              salary: balance,
            ),
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
