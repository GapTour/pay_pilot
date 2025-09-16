import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_transactions/presentation/cubit/event_transactions_cubit.dart';
import 'package:pay_pilot/features/event_transactions/presentation/widgets/add_event_transaction_dialog_box.dart';
import 'package:pay_pilot/features/event_transactions/presentation/widgets/edit_event_transaction_dialog_box.dart';

class EventTransactionsScreen extends StatefulWidget {
  static const routeName =
      '/event-transactions/id:${AppArguments.eventDetails}';

  final String eventID;
  const EventTransactionsScreen({required this.eventID, super.key});

  @override
  State<EventTransactionsScreen> createState() =>
      _EventTransactionsScreenState();
}

class _EventTransactionsScreenState extends State<EventTransactionsScreen> {
  EventDetailsModel? eventDetails;

  @override
  void initState() {
    super.initState();

    context.read<EventTransactionsCubit>().loadTransactions(
      int.parse(widget.eventID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event\'s Transactions')),
      body: BlocBuilder<EventTransactionsCubit, EventTransactionsState>(
        builder: (context, state) {
          final List<Transactions> transactions = [];
          final isLoading =
              state is EventTransactionsInitial ||
              state is EventTransactionsLoading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is EventTransactionsSuccess) {
            eventDetails = state.eventDetails;
            transactions.addAll(state.eventDetails.transactions);
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            children: [
              Text(
                eventDetails!.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Gap(12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Engaged Team: '),
                    TextSpan(text: eventDetails!.team.title),
                  ],
                ),
              ),
              Gap(5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Date: '),
                    TextSpan(
                      text: DateFormat.yMEd().format(eventDetails!.date),
                    ),
                  ],
                ),
              ),
              Gap(12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Description: '),
                    TextSpan(text: eventDetails!.description ?? '-'),
                  ],
                ),
              ),
              Gap(8),
              Divider(),
              Gap(12),

              AppList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: transactions.length,
                emptyInboxMessage: 'There is no transaction yet!',
                itemBuilder: (context, index) {
                  return AppTile(
                    height: 75,
                    onEdit: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return EditEventTransactionDialogBox(
                            transaction: transactions[index],
                            eventID: int.parse(widget.eventID),
                            onPressedSubmit: (transaction) {
                              context
                                  .read<EventTransactionsCubit>()
                                  .updateTransaction(transaction);
                            },
                          );
                        },
                      );
                    },
                    onDelete: () {
                      context.read<EventTransactionsCubit>().deleteTransaction(
                        transactions[index].id,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                AmountHelper.integerToFormattedPrice(
                                  transactions[index].amount,
                                ),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Text(transactions[index].transactionType.name),
                          ],
                        ),
                        Gap(5),
                        Text(
                          'on ${DateFormat.MMMEd().format(transactions[index].date)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddEventTransactionDialogBox(
                eventID: int.parse(widget.eventID),
                onPressedSubmit: (transaction) {
                  context.read<EventTransactionsCubit>().insertTransaction(
                    transaction,
                  );
                },
              );
            },
          );
        },
        backgroundColor: kSecondaryColor,
        splashColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
