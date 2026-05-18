import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/core/utils/extensions/empty_text.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
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
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Join at:  ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: memberDetail.joinAt == null
                            ? '-'
                            : memberDetail.joinAt!.formattedToJalali_yearMonth,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Birthday:  ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: memberDetail.birthday == null
                            ? '-'
                            : memberDetail
                                  .birthday!
                                  .formattedToJalali_yearMonthDay,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                Gap(5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Description:  ',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: memberDetail.description.defaultEmptyText(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
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
