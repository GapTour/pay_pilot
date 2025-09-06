import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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

          return GridView.builder(
            itemCount: members.length,
            padding: const EdgeInsets.all(18),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380,
              childAspectRatio: 6,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
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
                child: Card(
                  child: Row(
                    children: [
                      Gap(15),
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
                      Gap(15),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
