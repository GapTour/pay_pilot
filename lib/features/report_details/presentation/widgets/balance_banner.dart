import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class BalanceBanner extends StatefulWidget {
  final List<EventDetailsModel> events;
  const BalanceBanner({required this.events, super.key});

  @override
  State<BalanceBanner> createState() => _BalanceBannerState();
}

class _BalanceBannerState extends State<BalanceBanner> {
  final List<TransactionModel> transactions = [];

  void fetchTransactions(List<EventDetailsModel> events) {
    transactions.clear();

    for (var event in events) {
      transactions.addAll(event.transactions);
    }
  }

  double get totalIncomes {
    return transactions.fold(0, (previousValue, element) {
      if (element.transactionType == TransactionType.expense) {
        return previousValue;
      }
      return previousValue + element.amount;
    });
  }

  double get totalExpenses {
    return transactions.fold(0, (previousValue, element) {
      if (element.transactionType == TransactionType.income) {
        return previousValue;
      }
      return previousValue + element.amount;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchTransactions(widget.events);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kSecondaryColor.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selected Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Total Income: '),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalIncomes,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Total Expense: '),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalExpenses,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Total Balance: '),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalIncomes - totalExpenses,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: kPrimaryColor),
          Gap(2),

          SizedBox(
            height: 78,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 9),
              shrinkWrap: true,
              itemCount: widget.events.length,
              separatorBuilder: (context, index) => Gap(3),
              itemBuilder: (context, index) {
                final event = widget.events[index];

                return SizedBox(
                  width: 130,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: kSecondaryColor),
                          ),
                          Gap(5),
                          Text(
                            event.team.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(DateFormat.MMMEd().format(event.date)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(8),
        ],
      ),
    );
  }
}
