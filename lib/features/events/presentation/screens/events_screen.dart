import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/events/presentation/cubit/events_cubit.dart';
import 'package:pay_pilot/features/events/presentation/widgets/add_event_dialog_box.dart';
import 'package:pay_pilot/features/events/presentation/widgets/edit_event_dialog_box.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events';

  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<EventsCubit>().loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.event_appBarTitle)),
      body: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          final events = state.events;
          final isLoading =
              state.eventsStatus is EventInitial ||
              state.eventsStatus is EventLoading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return AppList(
            itemCount: events.length,
            emptyInboxMessage: S.current.event_emptyStateContent,
            itemBuilder: (context, index) {
              return AppTile(
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EditEventDialogBox(
                        eventDetails: events[index],
                        teams: state.teams,
                        onPressedSubmit: (event) {
                          context.read<EventsCubit>().editEvent(event);
                        },
                      );
                    },
                  );
                },
                onPreview: () {
                  context.pushNamed(
                    AppRoutes.eventDetailsScreen,
                    pathParameters: {
                      AppArguments.eventDetails: '${events[index].id}',
                    },
                  );
                },
                // onDelete: () {
                //   context.read<EventsCubit>().deleteEvent(events[index].id);
                // },
                previewButtonTitle: S.current.button_title_preview,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      events[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Gap(3),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: S.current.contentTitle_onDate,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: events[index]
                                .date
                                .formattedToJalali_yearMonthDayWeekDay,
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
      ),
      floatingActionButton: BlocBuilder<EventsCubit, EventsState>(
        builder: (context, state) {
          final isLoading =
              state.eventsStatus is EventInitial ||
              state.eventsStatus is EventLoading;
          final isFailure = state.eventsStatus is EventFailure;

          return FloatingActionButton(
            onPressed: isLoading || isFailure
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AddEventDialogBox(
                          teams: state.teams,
                          onPressedSubmit: (event) {
                            context.read<EventsCubit>().addEvent(event);
                          },
                        );
                      },
                    );
                  },
            backgroundColor: kSecondaryColor,
            splashColor: kPrimaryColor,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
