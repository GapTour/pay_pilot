import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
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
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selected Events',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(color: kPrimaryColor),
                ),
                Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Income:  ',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: kPrimaryColor),
                      ),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalIncomes,
                        ),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Expense:  ',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: kPrimaryColor),
                      ),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalExpenses,
                        ),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Balance:  ',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: kPrimaryColor),
                      ),
                      TextSpan(
                        text: AmountHelper.integerToFormattedPrice(
                          totalIncomes - totalExpenses,
                        ),
                        style: Theme.of(context).textTheme.displayMedium,
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
            height: 65,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 9),
              shrinkWrap: true,
              itemCount: widget.events.length,
              separatorBuilder: (context, index) => Gap(3),
              itemBuilder: (context, index) {
                final event = widget.events[index];

                return SizedBox(
                  width: 158,
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
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Gap(5),
                          Text(
                            event.team.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            event.date.formattedToJalali_yearMonthDay,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
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
