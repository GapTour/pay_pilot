import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_ratio_dialog_box.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_transaction_dialog_box.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_details_title.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_ratios_list.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_report_list.dart';
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
  // EventDetailsModel? eventDetails;
  late int eventID;

  @override
  void initState() {
    super.initState();

    eventID = int.parse(widget.eventID);
    context.read<EventDetailsCubit>().loadTransactions(eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Details')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: [
          EventDetailsTitle(),
          Gap(30),
          BlocBuilder<EventDetailsCubit, EventDetailsState>(
            buildWhen: (p, c) => p.currentPage != c.currentPage,
            builder: (context, state) {
              return Column(
                children: [
                  EventTabBar(state: state),
                  Gap(25),
                  if (state.currentPage.isTransactions)
                    EventTransactionsList(eventID),
                  if (state.currentPage.isMembers) EventRatiosList(eventID),
                  if (state.currentPage.isReport) EventReportList(eventID),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          late IconData icon;

          if (state.currentPage.isTransactions) icon = Icons.add_card_rounded;
          if (state.currentPage.isMembers) icon = Icons.rate_review_rounded;
          if (state.currentPage.isReport) {
            return SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  if (state.currentPage.isMembers) {
                    return AddEventRatioDialogBox(
                      eventID: int.parse(widget.eventID),
                      members: state.members,
                      addedMembers: state.addedMembers,
                      onPressedSubmit: (ratio) {
                        context.read<EventDetailsCubit>().insertRatio(ratio);
                      },
                    );
                  }

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
            child: Icon(icon),
          );
        },
      ),
    );
  }
}
