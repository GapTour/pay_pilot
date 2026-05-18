import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/helpers/orders_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_orders_filtering.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EventOrdersBanner extends StatelessWidget {
  const EventOrdersBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventTransactionStatus != c.eventTransactionStatus) return true;
        if (p.eventOrderStatus != c.eventOrderStatus) return true;
        if (p.eventDetailStatus != c.eventDetailStatus) return true;
        if (p.filteredOrders != c.filteredOrders) return true;
        return false;
      },
      builder: (context, state) {
        final orders = <ResponseOrder>[];
        final members = <ResponseMember>[];
        final guests = <ResponseGuest>[];
        final menuItems = <ResponseMenu>[];
        final transactions = <ResponseEventTransaction>[];
        final ordersOverview = <(String, List<ResponseMenu>, int)>[];

        if (state.eventDetailStatus is EventDetailSuccess) {
          final eventDetailStatus =
              (state.eventDetailStatus as EventDetailSuccess);
          members.addAll(eventDetailStatus.members);
          guests.addAll(eventDetailStatus.guests);
          orders.addAll(eventDetailStatus.eventDetails.orders);
          menuItems.addAll(eventDetailStatus.menuItems);
          transactions.addAll(eventDetailStatus.eventDetails.transactions);
          ordersOverview.addAll(
            OrdersHelper.calculateOrdersOverview(orders, menuItems),
          );
        }

        if (orders.isEmpty) return SizedBox.shrink();

        final int totalGuests = orders
            .map((e) => e.orderedByGuest != null ? 1 : 0)
            .toList()
            .reduce((a, b) => a + b);
        final int totalMembers = orders
            .map((e) => e.orderedByMember != null ? 1 : 0)
            .toList()
            .reduce((a, b) => a + b);
        final int totalOrders = orders.length;
        final int notAttendedOrder = orders
            .map((e) => e.orders.isEmpty ? 1 : 0)
            .toList()
            .reduce((a, b) {
              return a + b;
            });
        ordersOverview.insert(0, ('All', [], totalOrders));
        // final int notDeliveredOrders = orders
        //     .map((e) => e.isDelivered ? 0 : 1)
        //     .toList()
        //     .reduce((a, b) => a + b);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Capacity: $totalOrders (Guests: $totalGuests, Members: $totalMembers)',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                if (notAttendedOrder > 0)
                  Text(
                    'Not Attended : $notAttendedOrder',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                Divider(color: kPrimaryColor),
                Gap(2),
                EventOrdersFiltering(ordersOverview: ordersOverview),
              ],
            ),
          ),
        );
      },
    );
  }
}
