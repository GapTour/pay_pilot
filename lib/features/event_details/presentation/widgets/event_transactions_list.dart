import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/edit_event_transaction_dialog_box.dart';

class EventTransactionsList extends StatelessWidget {
  final String eventID;
  final List<TransactionModel> transactions;
  const EventTransactionsList({
    required this.eventID,
    required this.transactions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppList(
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
                  eventID: int.parse(eventID),
                  onPressedSubmit: (transaction) {
                    context.read<EventDetailsCubit>().updateTransaction(
                      transaction,
                    );
                  },
                );
              },
            );
          },
          onDelete: () {
            context.read<EventDetailsCubit>().deleteTransaction(
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
    );
  }
}
