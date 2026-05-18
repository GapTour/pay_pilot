import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/teams/presentation/cubit/teams_cubit.dart';
import 'package:pay_pilot/features/teams/presentation/widgets/add_team_dialog_box.dart';
import 'package:pay_pilot/features/teams/presentation/widgets/edit_team_dialog_box.dart';

class TeamsScreen extends StatefulWidget {
  static const routeName = '/teams';

  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TeamsCubit>().loadTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teams')),
      body: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          final teams = state.teams;
          final isLoading =
              state.teamsStatus == TeamsStatus.loading ||
              state.teamsStatus == TeamsStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return AppList(
            itemCount: teams.length,
            emptyInboxMessage: 'There is no team yet!',
            itemBuilder: (context, index) {
              return AppTile(
                previewButtonTitle: 'Team\'s Members',
                onPreview: () {
                  context.pushNamed(
                    AppRoutes.teamMembersScreen,
                    pathParameters: {
                      AppArguments.teamDetails: '${teams[index].id}',
                    },
                  );
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EditTeamDialogBox(
                        team: teams[index],
                        onPressedSubmit: (team) {
                          context.read<TeamsCubit>().updateTeam(team);
                        },
                      );
                    },
                  );
                },
                onDelete: () {
                  context.read<TeamsCubit>().deleteTeam(teams[index].id);
                },
                child: Text(
                  teams[index].title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddTeamDialogBox(
                onPressedSubmit: (team) {
                  context.read<TeamsCubit>().addTeam(team);
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
