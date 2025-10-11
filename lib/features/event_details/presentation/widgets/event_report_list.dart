import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/data/models/balance_model.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';

class EventReportList extends StatefulWidget {
  final int eventID;
  const EventReportList(this.eventID, {super.key});

  @override
  State<EventReportList> createState() => _EventReportListState();
}

class _EventReportListState extends State<EventReportList> {
  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().loadTransactions(widget.eventID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsCubit, EventDetailsState>(
      builder: (context, state) {
        final List<BalanceModel> memberBalances = state.membersBalance;

        if (state.eventTabsStatus.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return AppList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: memberBalances.length,
          emptyInboxMessage: 'There is no ratios yet!',
          itemBuilder: (context, index) {
            return AppTile(
              height: 56,
              isActive: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memberBalances[index].member.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Salary ',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        AmountHelper.integerToFormattedPrice(
                          memberBalances[index].totalBalance,
                        ),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
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
