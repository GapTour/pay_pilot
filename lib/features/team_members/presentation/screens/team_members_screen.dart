import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/empty_text.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/team_members/presentation/cubit/ratios_cubit.dart';
import 'package:pay_pilot/features/team_members/presentation/widgets/add_ratio_dialog_box.dart';
import 'package:pay_pilot/features/team_members/presentation/widgets/edit_ratio_dialog_box.dart';

class TeamMembersScreen extends StatefulWidget {
  static const routeName = '/team-members/id:${AppArguments.teamDetails}';

  final String teamID;

  const TeamMembersScreen({super.key, required this.teamID});

  @override
  State<TeamMembersScreen> createState() => _TeamMembersScreenState();
}

class _TeamMembersScreenState extends State<TeamMembersScreen> {
  @override
  void initState() {
    super.initState();

    context.read<RatiosCubit>().loadRatios(int.parse(widget.teamID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team\'s Members')),
      body: BlocBuilder<RatiosCubit, RatiosState>(
        builder: (context, state) {
          late Team teamInfo;
          final teamMembers = state.ratios;
          final isLoading =
              state.ratioStatus is RatioInitial ||
              state.ratioStatus is RatioLoading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.ratioStatus is RatioSuccess) {
            teamInfo = (state.ratioStatus as RatioSuccess).team;
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            children: [
              Text(
                teamInfo.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gap(12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Description:  ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextSpan(
                      text: teamInfo.description.defaultEmptyText(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Gap(8),
              Divider(),
              Gap(12),

              AppList(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: teamMembers.length,
                emptyInboxMessage: 'There is no member yet!',
                itemBuilder: (context, index) {
                  return AppTile(
                    height: 38,
                    onEdit: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return EditRatioDialogBox(
                            teamMember: teamMembers[index],
                            team: teamInfo,
                            members:
                                (state.ratioStatus as RatioSuccess).members,
                            addedMembers: (state.ratioStatus as RatioSuccess)
                                .addedMembers,
                            onPressedSubmit: (ratio) {
                              context.read<RatiosCubit>().updateRatio(ratio);
                            },
                          );
                        },
                      );
                    },
                    onDelete: () {
                      context.read<RatiosCubit>().deleteRatio(
                        int.parse(widget.teamID),
                        teamMembers[index].id,
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            teamMembers[index].member.name,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        Text(
                          '%${teamMembers[index].ratio}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Gap(150),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<RatiosCubit, RatiosState>(
        builder: (context, state) {
          final isLoading =
              state.ratioStatus is RatioInitial ||
              state.ratioStatus is RatioLoading;
          final isFailure = state.ratioStatus is RatioFailure;

          return FloatingActionButton(
            onPressed: isFailure || isLoading
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AddRatioDialogBox(
                          team: (state.ratioStatus as RatioSuccess).team,
                          members: (state.ratioStatus as RatioSuccess).members,
                          addedMembers:
                              (state.ratioStatus as RatioSuccess).addedMembers,
                          onPressedSubmit: (ratio) {
                            context.read<RatiosCubit>().addRatio(ratio);
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
