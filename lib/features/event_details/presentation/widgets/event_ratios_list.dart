import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/edit_event_ratio_dialog_box.dart';

class EventRatiosList extends StatelessWidget {
  final int eventID;
  const EventRatiosList(this.eventID, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsCubit, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.memberRatios != c.memberRatios) return true;
        if (p.eventTabsStatus != c.eventTabsStatus) return true;
        return false;
      },
      builder: (context, state) {
        final List<MemberRatioModel> ratios = state.memberRatios;
        ratios.sort((a, b) => b.ratio.compareTo(a.ratio));

        if (state.eventTabsStatus.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return AppList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: ratios.length,
          emptyInboxMessage: 'There is no ratios yet!',
          itemBuilder: (context, index) {
            return AppTile(
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return EditEventRatioDialogBox(
                      memberRatio: ratios[index],
                      eventID: eventID,
                      members: state.members,
                      addedMembers: state.addedMembers,
                      onPressedSubmit: (submittedRatio) {
                        context.read<EventDetailsCubit>().updateRatio(
                          submittedRatio,
                        );
                      },
                    );
                  },
                );
              },
              onDelete: () {
                context.read<EventDetailsCubit>().deleteRatio(ratios[index].id);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      ratios[index].member.name,
                      textAlign: TextAlign.left,
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
