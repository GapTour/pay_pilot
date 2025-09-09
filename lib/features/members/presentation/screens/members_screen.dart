import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';
import 'package:pay_pilot/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot/features/members/presentation/widgets/add_member_dialog_box.dart';

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

          if (members.isEmpty) {
            return const Center(child: Text('No members found.'));
          }

          return ListView.separated(
            itemCount: members.length,
            padding: const EdgeInsets.all(8),
            separatorBuilder: (context, index) => Gap(3),
            itemBuilder: (context, index) {
              return AppElevatedButton(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AddMemberDialogBox(
                        member: members[index],
                        onPressedSubmit: (member) {
                          context.read<MembersCubit>().updateMember(member);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          members[index].name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      Text(
                        '${members[index].percentage.toString()}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
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
