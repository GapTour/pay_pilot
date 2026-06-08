import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/edit_event_transaction_dialog_box.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class EventTransactionsList extends StatelessWidget {
  final int eventID;
  const EventTransactionsList(this.eventID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventTransactionStatus != c.eventTransactionStatus) return true;
        if (p.eventDetailStatus != c.eventDetailStatus) return true;
        return false;
      },
      builder: (context, state) {
        final transactions = <ResponseEventTransaction>[];
        final members = <ResponseMember>[];
        final guests = <ResponseGuest>[];

        if (state.eventTransactionStatus is EventTransactionLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventDetailStatus is EventDetailSuccess) {
          final eventDetailStatus =
              (state.eventDetailStatus as EventDetailSuccess);
          members.addAll(eventDetailStatus.members);
          guests.addAll(eventDetailStatus.guests);
          transactions.addAll(eventDetailStatus.eventDetails.transactions);
        }

        return AppList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: transactions.length,
          emptyInboxMessage: S.current.transaction_emptyStateContent,
          itemBuilder: (context, index) {
            final paidBy =
                members
                    .firstWhereOrNull(
                      (m) => m.id == transactions[index].paidByMember,
                    )
                    ?.name ??
                guests
                    .firstWhereOrNull(
                      (g) => g.id == transactions[index].paidByGuest,
                    )
                    ?.name ??
                S.current.contentTitle_unknown;

            return AppTile(
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return EditEventTransactionDialogBox(
                      transaction: transactions[index],
                      responseGuests: guests,
                      responseMembers: members,
                      eventID: eventID,
                      onPressedSubmit: (transaction) {
                        context.read<EventDetailsBloc>().add(
                          EditTransaction(transaction),
                        );
                      },
                    );
                  },
                );
              },
              onDelete: () {
                context.read<EventDetailsBloc>().add(
                  DeleteTransaction(
                    TransactionParams(
                      id: transactions[index].id,
                      amount: 0,
                      attachment: null,
                      description: null,
                      eventID: 0,
                      guestID: null,
                      memberID: null,
                      transactionDate: DateTime.now(),
                      transactionType: transactions[index].transactionType,
                      // TODO(mahDyarZ): work on this feature later
                      hasPermissionDeleteOrder: true,
                    ),
                  ),
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
                            transactions[index].transactionType,
                          ),
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: transactions[index].transactionType.isExpense
                              ? Colors.red
                              : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 4,
                          ),
                          child: Text(
                            transactions[index].transactionType.isIncome
                                ? S.current.contentTitle_income
                                : S.current.contentTitle_expense,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: S.current.contentTitle_onDate,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextSpan(
                          text: transactions[index]
                              .date
                              .formattedToJalali_yearMonthDay,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  Gap(5),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: S.current.contentTitle_byWho,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        TextSpan(
                          text: paidBy,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
