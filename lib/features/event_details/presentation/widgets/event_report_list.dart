import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_balance.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';

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

    context.read<EventDetailsBloc>().add(LoadReportList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventReportStatus != c.eventReportStatus) return true;
        if (p.eventDetailStatus != c.eventDetailStatus) return true;
        return false;
      },
      builder: (context, state) {
        final memberBalances = <ResponseEventBalance>[];

        if (state.eventReportStatus is! EventReportSuccess) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventReportStatus is EventReportSuccess) {
          memberBalances
            ..addAll(
              (state.eventReportStatus as EventReportSuccess).membersBalance,
            )
            ..sort((a, b) => b.salary.compareTo(a.salary));
        }

        return AppList(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: memberBalances.length,
          emptyInboxMessage: 'There is no ratios yet!',
          itemBuilder: (context, index) {
            return AppTile(
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
                          memberBalances[index].salary,
                        ),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  if ((memberBalances[index].expenses ?? 0) > 0)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Paid expenses ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Text(
                          AmountHelper.integerToFormattedPrice(
                            memberBalances[index].expenses!,
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
