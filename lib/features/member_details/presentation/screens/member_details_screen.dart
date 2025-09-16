import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/features/member_details/presentation/cubit/members_details_cubit.dart';

class MemberDetailsScreen extends StatefulWidget {
  static const routeName = '/members-details/id:${AppArguments.memberDetails}';

  final String memberID;
  const MemberDetailsScreen({super.key, required this.memberID});

  @override
  State<MemberDetailsScreen> createState() => _MemberDetailsScreenState();
}

class _MemberDetailsScreenState extends State<MemberDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MembersDetailsCubit>().loadMembers(int.parse(widget.memberID));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Member Details')),
      body: BlocBuilder<MembersDetailsCubit, MembersDetailsState>(
        builder: (context, state) {
          if (state.membersStatus is MemberSuccess) {
            final memberDetail = (state.membersStatus as MemberSuccess).member;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              children: [
                Text(
                  memberDetail.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Gap(12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Join at: '),
                      TextSpan(
                        text: memberDetail.joinAt == null
                            ? '-'
                            : DateFormat.MMMMEEEEd().format(
                                memberDetail.joinAt!,
                              ),
                      ),
                    ],
                  ),
                ),
                Gap(12),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Description: '),
                      TextSpan(text: memberDetail.description ?? '-'),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
