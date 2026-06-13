import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/data/params/event_story_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_modal_bottom_sheet.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_order_modal_view.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_ratio_modal_view.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/add_event_transaction_modal_view.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_more_details.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_orders_list.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_ratios_list.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_report_list.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_tab_bar.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_transactions_banner.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_transactions_list.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

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
    context.read<EventDetailsBloc>().add(LoadEventDetails(eventID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.eventDetails_appBarTitle)),
      body: Column(
        children: [
          Gap(12),
          EventTransactionsBanner(),
          Gap(12),
          BlocBuilder<EventDetailsBloc, EventDetailsState>(
            buildWhen: (p, c) => p.currentPage != c.currentPage,
            builder: (context, state) {
              return EventTabBar(state: state);
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                bottom: 150,
                right: 15,
                left: 15,
                top: 8,
              ),
              children: [
                BlocBuilder<EventDetailsBloc, EventDetailsState>(
                  buildWhen: (p, c) => p.currentPage != c.currentPage,
                  builder: (context, state) {
                    if (state.currentPage.isDetails) {
                      return EventMoreDetails(eventID);
                    }
                    if (state.currentPage.isTransactions) {
                      return EventTransactionsList(eventID);
                    }
                    if (state.currentPage.isMembers) {
                      return EventRatiosList(eventID);
                    }
                    if (state.currentPage.isReport) {
                      return EventReportList(eventID);
                    }
                    if (state.currentPage.isOrder) {
                      return EventOrdersList();
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<EventDetailsBloc, EventDetailsState>(
        builder: (context, state) {
          late IconData icon;
          final members = <ResponseMember>[];
          final guests = <ResponseGuest>[];
          final ratios = <ResponseEventRatio>[];
          final menuItems = <ResponseMenu>[];
          final addedMembers = <int, double>{};

          if (state.eventDetailStatus is EventDetailSuccess) {
            final eventDetailStatus =
                (state.eventDetailStatus as EventDetailSuccess);
            members.addAll(eventDetailStatus.members);
            guests.addAll(eventDetailStatus.guests);
            menuItems.addAll(eventDetailStatus.menuItems);
            ratios
              ..addAll(eventDetailStatus.eventDetails.memberRatios)
              ..sort((a, b) => b.ratio.compareTo(a.ratio));
            for (var m in members) {
              final double? ratio = ratios
                  .firstWhereOrNull((r) => r.memberID == m.id)
                  ?.ratio;

              if (ratio != null) addedMembers[m.id] = ratio;
            }
          }

          if (state.currentPage.isTransactions) icon = Icons.add_card_rounded;
          if (state.currentPage.isMembers) icon = Icons.edit_document;
          if (state.currentPage.isOrder) icon = Icons.menu_book_rounded;
          if (state.currentPage.isReport) {
            return SizedBox.shrink();
          }
          if (state.currentPage.isDetails) icon = Icons.theaters_outlined;

          return FloatingActionButton(
            onPressed: () async {
              if (state.currentPage.isDetails) {
                final passedData = await context
                    .pushNamed<Map<String, dynamic>>(
                      AppRoutes.eventStoryScreen,
                      extra: {'eventID': eventID},
                    );

                if (passedData == null) return;
                final storyParams = EventStoryParams.fromJson(
                  passedData['encoded'],
                );

                if (storyParams.id == null && context.mounted) {
                  context.read<EventDetailsBloc>().add(AddStory(storyParams));
                }
                if (storyParams.id != null && context.mounted) {
                  context.read<EventDetailsBloc>().add(EditStory(storyParams));
                }
                return;
              }

              if (state.currentPage.isTransactions) {
                AppModalBottomSheet.maxHeightWithAppBar(
                  header: S.current.eventDetails_addEventTransaction,
                  child: AddEventTransactionModalView(
                    eventID: int.parse(widget.eventID),
                    onPressedSubmit: (transactions) {
                      context.read<EventDetailsBloc>().add(
                        AddTransaction(transactions),
                      );
                    },
                    responseMembers: members,
                    responseGuests: guests,
                  ),
                );
                return;
              }

              if (state.currentPage.isOrder) {
                AppModalBottomSheet.maxHeightWithAppBar(
                  header: S.current.eventDetails_addEventOrder,
                  child: AddEventOrderModalView(
                    eventID: int.parse(widget.eventID),
                    responseMembers: members,
                    responseGuests: guests,
                    menuItems: menuItems,
                    onPressedSubmit: (order) {
                      context.read<EventDetailsBloc>().add(AddOrder(order));
                    },
                  ),
                );
                return;
              }

              if (state.currentPage.isMembers) {
                AppModalBottomSheet.minHeightWithAppBar(
                  header: S.current.eventDetails_addEventRatio,
                  child: AddEventRatioModalView(
                    eventID: eventID,
                    onPressedSubmit: (ratioEvent) {
                      context.read<EventDetailsBloc>().add(
                        AddEventRatio(ratioEvent),
                      );
                    },
                    addedMembers: addedMembers,
                    members: members,
                  ),
                );
                return;
              }
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
