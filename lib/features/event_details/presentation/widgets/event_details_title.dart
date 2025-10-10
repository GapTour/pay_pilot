import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/data/models/event_details_model.dart';
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventDetails.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Gap(12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Engaged Team: '),
                  TextSpan(text: eventDetails.team.title),
                ],
              ),
            ),
            Gap(5),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Date: '),
                  TextSpan(text: DateFormat.yMEd().format(eventDetails.date)),
                ],
              ),
            ),
            Gap(12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Description: '),
                  TextSpan(text: eventDetails.description ?? '-'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
