import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_transaction_dialog_box.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_tab_bar.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_transactions_list.dart';

class EventDetailsScreen extends StatefulWidget {
  static const routeName = '/event-details/id:${AppArguments.eventDetails}';

  final String eventID;
  const EventDetailsScreen({required this.eventID, super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventDetailsModel? eventDetails;

  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().loadTransactions(
      int.parse(widget.eventID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Details')),
      body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          final List<TransactionModel> transactions = [];
          final isLoading =
              state.eventDetailStatus is EventDetailInitial ||
              state.eventDetailStatus is EventDetailLoading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.eventDetailStatus is EventDetailSuccess) {
            eventDetails =
                (state.eventDetailStatus as EventDetailSuccess).eventDetails;
            transactions.addAll(eventDetails!.transactions);
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
              Gap(30),
              EventTabBar(state: state),
              Gap(25),
              if (state.currentPage == EventDetailsPage.transactions)
                EventTransactionsList(
                  eventID: widget.eventID,
                  transactions: transactions,
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
                  context.read<EventDetailsCubit>().insertTransaction(
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
