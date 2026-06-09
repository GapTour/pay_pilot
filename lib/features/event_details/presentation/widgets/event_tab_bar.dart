import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_tab.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';

class EventTabBar extends StatelessWidget {
  final EventDetailsState state;
  const EventTabBar({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = state.currentPage;

    return AppTab(
      tabs: [
        TabTile(
          isSelected: currentPage.isDetails,
          title: 'جزییات',
          onTap: () {
            context.read<EventDetailsBloc>().add(
              ChangePage(EventDetailsPage.details),
            );
          },
        ),
        TabTile(
          isSelected: currentPage.isTransactions,
          title: S.current.eventDetails_tabBar_transactions,
          onTap: () {
            context.read<EventDetailsBloc>().add(
              ChangePage(EventDetailsPage.transactions),
            );
          },
        ),
        TabTile(
          isSelected: currentPage.isOrder,
          title: S.current.eventDetails_tabBar_orders,
          onTap: () {
            context.read<EventDetailsBloc>().add(
              ChangePage(EventDetailsPage.orders),
            );
          },
        ),
        TabTile(
          isSelected: currentPage.isMembers,
          title: S.current.eventDetails_tabBar_members,
          onTap: () {
            context.read<EventDetailsBloc>().add(
              ChangePage(EventDetailsPage.members),
            );
          },
        ),
        TabTile(
          isSelected: currentPage.isReport,
          title: S.current.eventDetails_tabBar_report,
          onTap: () {
            context.read<EventDetailsBloc>().add(
              ChangePage(EventDetailsPage.report),
            );
          },
        ),
      ],
    );
  }
}
