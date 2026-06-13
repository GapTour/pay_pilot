import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_modal_bottom_sheet.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/edit_event_ratio_modal_view.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class EventRatiosList extends StatelessWidget {
  final int eventID;
  const EventRatiosList(this.eventID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventRatioStatus != c.eventRatioStatus) return true;
        if (p.eventDetailStatus != c.eventDetailStatus) return true;
        return false;
      },
      builder: (context, state) {
        final ratios = <ResponseEventRatio>[];
        final members = <ResponseMember>[];
        final addedMembers = <int, double>{};

        if (state.eventRatioStatus is EventRatioLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventDetailStatus is EventDetailSuccess) {
          final eventDetailStatus =
              (state.eventDetailStatus as EventDetailSuccess);

          ratios
            ..addAll(eventDetailStatus.eventDetails.memberRatios)
            ..sort((a, b) => b.ratio.compareTo(a.ratio));

          members.addAll(eventDetailStatus.members);
          for (var m in members) {
            final double? ratio = ratios
                .firstWhereOrNull((r) => r.memberID == m.id)
                ?.ratio;

            if (ratio != null) addedMembers[m.id] = ratio;
          }
        }

        return AppList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: ratios.length,
          emptyInboxMessage: S.current.ratio_emptyStateContent,
          itemBuilder: (context, index) {
            final String memberName =
                members.firstWhereOrNull((m) {
                  return m.id == ratios[index].memberID;
                })?.name ??
                S.current.contentTitle_unknown;

            return AppTile(
              onEdit: () {
                AppModalBottomSheet.minHeightWithAppBar(
                  header: S.current.eventDetails_editEventRatio,
                  child: EditEventRatioModalView(
                    memberRatio: ratios[index],
                    eventID: eventID,
                    members: members,
                    addedMembers: addedMembers,
                    onPressedSubmit: (submittedRatio) {
                      context.read<EventDetailsBloc>().add(
                        EditEventRatio(submittedRatio),
                      );
                    },
                  ),
                );
              },
              onDelete: () {
                context.read<EventDetailsBloc>().add(
                  DeleteEventRatio(ratios[index].id),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      memberName,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Text(
                    '% ${ratios[index].ratio}',
                    style: Theme.of(context).textTheme.displayLarge,
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
