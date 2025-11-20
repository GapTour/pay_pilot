import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
import 'package:pay_pilot/core/utils/extensions/empty_text.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';

class EventDetailsTitle extends StatelessWidget {
  const EventDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsCubit, EventDetailsState>(
      buildWhen: (p, c) => p.eventDetailStatus != c.eventDetailStatus,
      builder: (context, state) {
        late EventDetailsModel eventDetails;
        final isLoading =
            state.eventDetailStatus is EventDetailInitial ||
            state.eventDetailStatus is EventDetailLoading;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventDetailStatus is EventDetailSuccess) {
          eventDetails =
              (state.eventDetailStatus as EventDetailSuccess).eventDetails;
        }

        return SizedBox(
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
                      text: 'Engaged Team:  ',
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
                      text: 'Date:  ',
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
                      text: 'Description:  ',
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
        );
      },
    );
  }
}
