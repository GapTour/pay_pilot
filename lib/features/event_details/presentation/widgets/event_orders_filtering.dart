// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/helpers/orders_helper.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot/features/event_details/presentation/bloc/event_details_bloc.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EventOrdersFiltering extends StatefulWidget {
  final List<(String, List<ResponseMenu>, int)> ordersOverview;
  const EventOrdersFiltering({super.key, required this.ordersOverview});

  @override
  State<EventOrdersFiltering> createState() => _EventOrdersFilteringState();
}

class _EventOrdersFilteringState extends State<EventOrdersFiltering> {
  int selectedIndex = 0;
  int index = -1;
  final filteredOrders = <int>[];

  @override
  void initState() {
    super.initState();

    filteredOrders.addAll(
      context.read<EventDetailsBloc>().state.filteredOrders,
    );

    selectedIndex = OrdersHelper.initSelectedOrderCategory(
      filteredOrders,
      widget.ordersOverview,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventDetailsBloc, EventDetailsState>(
      listenWhen: (p, c) {
        if (p.filteredOrders != c.filteredOrders) return true;
        return false;
      },
      listener: (context, state) {
        index = -1;
        filteredOrders
          ..clear
          ..addAll(state.filteredOrders);
      },
      buildWhen: (p, c) {
        if (p.filteredOrders != c.filteredOrders) return true;
        return false;
      },
      builder: (context, state) {
        return AppWrapBuilder(
          widget.ordersOverview.map((e) {
            index++;

            final title = e.$1;
            final menuItems = e.$2;
            final count = e.$3;
            final itemIndex = index;

            return GestureDetector(
              onTap: () {
                selectedIndex = itemIndex;
                context.read<EventDetailsBloc>().add(
                  UpdateFilteredOrders(
                    itemIndex == 0 ? [] : menuItems.map((i) => i.id).toList(),
                  ),
                );
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedIndex == itemIndex
                      ? kSecondaryColor.withAlpha(150)
                      : null,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 3,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Gap(5),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: kOnPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            '$count',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.zero,
        );
      },
    );
  }
}
