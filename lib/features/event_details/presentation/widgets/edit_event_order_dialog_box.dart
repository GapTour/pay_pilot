import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_custom_widget_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/event_details/data/models/response_order.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EditEventOrderDialogBox extends StatefulWidget {
  final List<ResponseMenu> menuItems;
  final List<ResponseMember> responseMembers;
  final List<ResponseGuest> responseGuests;
  final ResponseOrder order;
  final Function(EventOrderParams params) onSubmit;
  const EditEventOrderDialogBox({
    super.key,
    required this.menuItems,
    required this.order,
    required this.responseMembers,
    required this.responseGuests,
    required this.onSubmit,
  });

  @override
  State<EditEventOrderDialogBox> createState() =>
      _EditEventOrderDialogBoxState();
}

class _EditEventOrderDialogBoxState extends State<EditEventOrderDialogBox> {
  final TextEditingController nameController = TextEditingController();
  final selectedItems = <ResponseMenu>[];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.order.orderedByGuest != null) {
      nameController.text = widget.responseGuests
          .firstWhere((e) => e.id == widget.order.orderedByGuest)
          .name;
    }
    if (widget.order.orderedByMember != null) {
      nameController.text = widget.responseMembers
          .firstWhere((e) => e.id == widget.order.orderedByMember)
          .name;
    }

    for (var menuID in widget.order.orders) {
      final menuInfo = widget.menuItems.firstWhere((e) => e.id == menuID);
      selectedItems.add(menuInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCustomWidgetDialogBox(
      title: S.current.eventDetails_editEventOrder,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            label: S.current.textField_label_name,
            controller: nameController,
            readOnly: true,
          ),
          Gap(18),
          SizedBox(
            height: 28,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: selectedItems.isNotEmpty ? selectedItems.length : 1,
              separatorBuilder: (context, index) => Gap(8),
              itemBuilder: (context, index) {
                if (selectedItems.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text(
                      S.current.eventDetails_selectOrder,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  );
                }
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Text(
                      selectedItems[index].title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(12),
          Expanded(
            child: ListView.separated(
              itemCount: widget.menuItems.length,
              separatorBuilder: (context, index) => Gap(8),
              itemBuilder: (context, index) {
                final item = widget.menuItems[index];
                final isSelected = selectedItems.any((e) => e.id == item.id);

                return Row(
                  children: [
                    Checkbox.adaptive(
                      value: isSelected,
                      activeColor: kSecondaryColor,
                      onChanged: (value) {
                        if (value == true) selectedItems.add(item);
                        if (value == false) selectedItems.remove(item);

                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      onPressed: () {
        final params = EventOrderParams(
          id: widget.order.id,
          eventID: widget.order.eventID,
          memberID: widget.order.orderedByMember,
          guestID: widget.order.orderedByGuest,
          menuItemIDs: selectedItems.map((e) => e.id).toList(),
        );

        widget.onSubmit.call(params);
        context.pop();
      },
    );
  }
}
