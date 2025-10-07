import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';

class EventTabBar extends StatelessWidget {
  final EventDetailsState state;
  const EventTabBar({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = state.currentPage;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: kPrimaryContainerColor,
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              TabTile(
                isSelected: currentPage == EventDetailsPage.transactions,
                title: 'Transactions',
                tilePage: EventDetailsPage.transactions,
              ),
              TabTile(
                isSelected: currentPage == EventDetailsPage.members,
                title: 'Members',
                tilePage: EventDetailsPage.members,
              ),
              TabTile(
                isSelected: currentPage == EventDetailsPage.report,
                title: 'Report',
                tilePage: EventDetailsPage.report,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TabTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final EventDetailsPage tilePage;
  const TabTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.tilePage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 42,
      child: TextButton(
        onPressed: () {
          context.read<EventDetailsCubit>().changePage(tilePage);
        },

        style: TextButton.styleFrom(
          backgroundColor: isSelected ? kPrimaryContainerColor : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? kPrimaryColor : kPrimaryContainerColor,
            ),
          ),
        ),
      ),
    );
  }
}
