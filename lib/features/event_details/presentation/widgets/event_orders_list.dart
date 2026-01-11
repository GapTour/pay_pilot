import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/helpers/orders_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_list.dart';
import 'package:pay_pilot/core/widgets/app_tile.dart';
import 'package:pay_pilot/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/edit_event_order_dialog_box.dart';
import 'package:pay_pilot/features/event_details/presentation/widgets/event_orders_banner.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EventOrdersList extends StatelessWidget {
  const EventOrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      buildWhen: (p, c) {
        if (p.eventOrderStatus != c.eventOrderStatus) return true;
        if (p.eventTransactionStatus != c.eventTransactionStatus) return true;
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
        final filteredOrders = state.filteredOrders;

        if (state.eventOrderStatus is EventOrderLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.eventDetailStatus is EventDetailSuccess) {
          final eventDetailStatus =
              (state.eventDetailStatus as EventDetailSuccess);
          members.addAll(eventDetailStatus.members);
          guests.addAll(eventDetailStatus.guests);
          menuItems.addAll(eventDetailStatus.menuItems);
          transactions.addAll(eventDetailStatus.eventDetails.transactions);
          orders.addAll(
            OrdersHelper.filterAllOrders(
              filteredOrders,
              eventDetailStatus.eventDetails.orders,
            ),
          );
        }

        return Column(
          children: [
            EventOrdersBanner(),
            Gap(25),
            AppList(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: orders.length,
              emptyInboxMessage: 'There is no order yet!',
              itemBuilder: (context, index) {
                final order = orders[index];
                final hasTransaction = transactions.any(
                  (t) =>
                      t.paidByGuest != null &&
                          t.paidByGuest == order.orderedByGuest ||
                      t.paidByMember != null &&
                          t.paidByMember == order.orderedByMember,
                );
                final orderBy = extractName(order, members, guests);

                return AppTile(
                  isActive: !order.isDelivered,
                  onEdit: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return EditEventOrderDialogBox(
                          order: order,
                          responseGuests: guests,
                          responseMembers: members,
                          menuItems: menuItems,
                          onSubmit: (params) {
                            context.read<EventDetailsBloc>().add(
                              EditOrder(params),
                            );
                          },
                        );
                      },
                    );
                  },
                  onDelete: hasTransaction
                      ? null
                      : () {
                          context.read<EventDetailsBloc>().add(
                            DeleteOrder(order.id),
                          );
                        },
                  padding: EdgeInsets.only(right: 18, top: 5, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox.adaptive(
                        value: order.isDelivered,
                        activeColor: kSecondaryColor,
                        onChanged: order.orders.isEmpty
                            ? null
                            : (value) {
                                if (value != null) {
                                  context.read<EventDetailsBloc>().add(
                                    ChangeOrderDeliveryStatus(order.id, value),
                                  );
                                }
                              },
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    orderBy,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displayMedium,
                                  ),
                                ),
                                if (!hasTransaction) ...[
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.redAccent,
                                    size: 16,
                                  ),
                                  Gap(4),
                                  Text(
                                    'Unpaid',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.redAccent),
                                  ),
                                ],
                              ],
                            ),
                            Gap(5),
                            if (order.orders.isNotEmpty)
                              AppWrapBuilder(
                                extractMenuItems(context, order, menuItems),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  String extractName(
    ResponseOrder order,
    List<ResponseMember> members,
    List<ResponseGuest> guests,
  ) {
    String orderBy = 'Unknown';

    if (order.orderedByMember != null) {
      orderBy = members.firstWhere((e) => e.id == order.orderedByMember).name;
    }
    if (order.orderedByGuest != null) {
      orderBy = guests.firstWhere((e) => e.id == order.orderedByGuest).name;
    }

    return orderBy;
  }

  List<Widget> extractMenuItems(
    BuildContext context,
    ResponseOrder order,
    List<ResponseMenu> menu,
  ) {
    List<Widget> orderedList = [];

    for (var menuID in order.orders) {
      final menuInfo = menu.firstWhere((e) => e.id == menuID);
      orderedList.add(
        Text(menuInfo.title, style: Theme.of(context).textTheme.labelSmall),
      );
    }

    return orderedList;
  }
}
