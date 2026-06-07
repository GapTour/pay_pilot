import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/empty_text.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_details.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';

class EventDetailsTitle extends StatelessWidget {
  const EventDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) => p.eventDetailStatus != c.eventDetailStatus,
      builder: (context, state) {
        late ResponseEventDetails eventDetails;
        final isLoading =
            state.eventDetailStatus is EventDetailInitial ||
            state.eventDetailStatus is EventDetailFailure ||
            state.eventDetailStatus is EventDetailLoading;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventDetailStatus is EventDetailSuccess) {
          eventDetails =
              (state.eventDetailStatus as EventDetailSuccess).eventDetails;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventDetails.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.contentTitle_engagedTeam,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: eventDetails.team.title,
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
                        text: S.current.contentTitle_date,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: eventDetails
                            .date
                            .formattedToJalali_yearMonthDayWeekDay,
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
                        text: S.current.contentTitle_description,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: eventDetails.description.defaultEmptyText(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
