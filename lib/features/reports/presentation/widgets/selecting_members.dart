import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot/locator.dart';

class SelectingMembers extends StatelessWidget {
  final List<Member> selectedMembers;
  final Function(Member member) onPressed;
  const SelectingMembers({
    super.key,
    required this.selectedMembers,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembersCubit(locator())..loadMembers(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<MembersCubit, MembersState>(
            builder: (context, state) {
              final members = state.members;
              final isLoading =
                  state.membersStatus == MembersStatus.loading ||
                  state.membersStatus == MembersStatus.initial;

              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (members.isEmpty) {
                return const Center(child: Text('No members found.'));
              }

              return ListView.separated(
                itemCount: members.length,
                padding: EdgeInsets.symmetric(vertical: 12),
                separatorBuilder: (context, index) => Gap(3),
                itemBuilder: (context, index) {
                  final isSelected = selectedMembers.any(
                    (element) => element.id == members[index].id,
                  );

                  return Card(
                    child: Row(
                      children: [
                        Checkbox.adaptive(
                          value: isSelected,
                          onChanged: (value) {
                            onPressed.call(members[index]);
                          },
                        ),
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
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
