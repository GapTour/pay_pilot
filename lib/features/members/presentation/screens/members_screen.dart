import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot/features/members/presentation/widgets/add_member_dialog_box.dart';
import 'package:pay_pilot/features/members/presentation/widgets/edit_member_dialog_box.dart';

class MembersScreen extends StatefulWidget {
  static const routeName = '/members';

  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MembersCubit>().loadMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      body: BlocBuilder<MembersCubit, MembersState>(
        builder: (context, state) {
          final members = state.members;
          final isLoading =
              state.membersStatus == MembersStatus.loading ||
              state.membersStatus == MembersStatus.initial;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return AppList(
            itemCount: members.length,
            emptyInboxMessage: 'There is no member yet!',
            itemBuilder: (context, index) {
              return AppTile(
                height: 56,
                onPreview: () {
                  context.pushNamed(
                    AppRoutes.memberDetailsScreen,
                    pathParameters: {
                      AppArguments.memberDetails: '${members[index].id}',
                    },
                  );
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return EditMemberDialogBox(
                        member: members[index],
                        onPressedSubmit: (member) {
                          context.read<MembersCubit>().updateMember(member);
                        },
                      );
                    },
                  );
                },
                onDelete: () {
                  context.read<MembersCubit>().deleteMember(members[index].id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      members[index].name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Gap(3),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Join at: ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          if (members[index].joinAt != null)
                            TextSpan(
                              text: members[index]
                                  .joinAt!
                                  .formattedToJalali_yearMonth,
                              style: Theme.of(context).textTheme.displayMedium,
                            )
                          else
                            TextSpan(
                              text: '-',
                              style: Theme.of(context).textTheme.headlineSmall,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddMemberDialogBox(
                onPressedSubmit: (member) {
                  context.read<MembersCubit>().addMember(member);
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
