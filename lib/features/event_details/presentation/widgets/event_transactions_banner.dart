import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';

class EventTransactionsBanner extends StatelessWidget {
  const EventTransactionsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventTransactionStatus != c.eventTransactionStatus) return true;
        if (p.eventDetailStatus != c.eventDetailStatus) return true;
        return false;
      },
      builder: (context, state) {
        final incomes = state.totalIncomes;
        final expenses = state.totalExpenses;
        final transactions = <ResponseEventTransaction>[];
        final orders = <ResponseOrder>[];
        int totalGuests = 0;
        int unknownTransactions = 0;
        int totalExpenseTransactions = 0;
        int totalIncomeTransactions = 0;

        if (state.eventDetailStatus is EventDetailSuccess) {
          final eventDetailStatus =
              (state.eventDetailStatus as EventDetailSuccess);
          orders.addAll(eventDetailStatus.eventDetails.orders);
          transactions.addAll(eventDetailStatus.eventDetails.transactions);

          totalIncomeTransactions = transactions
              .where((element) => element.transactionType.isIncome)
              .length;
          totalExpenseTransactions = transactions
              .where((element) => element.transactionType.isExpense)
              .length;
          totalGuests = orders
              .where((element) => element.orderedByGuest != null)
              .length;
          unknownTransactions = transactions
              .where(
                (element) =>
                    element.transactionType.isIncome &&
                    element.paidByGuest == null,
              )
              .length;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'کل درآمد ($totalIncomeTransactions)',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Text(
                        '${incomes.toInt()}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'کل هزینه ($totalExpenseTransactions)',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Text(
                        '${expenses.toInt()}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'مانده',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Text(
                        '${incomes.toInt() - expenses.toInt()}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),

                  Divider(color: kPrimaryColor),
                  Text(
                    'جمع کل مهمانان $totalGuests',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),

                  if (unknownTransactions != 0) ...[
                    Divider(color: kPrimaryColor),
                    Text(
                      'شما $unknownTransactions تراکنش درآمد نامشخص دارید',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],

                  Gap(2),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
