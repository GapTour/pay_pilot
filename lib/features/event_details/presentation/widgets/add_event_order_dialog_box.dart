import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/enums/payment_source.dart';
import 'package:pay_pilot/core/data/params/event_order_params.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_custom_widget_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_tab.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class AddEventOrderDialogBox extends StatefulWidget {
  final List<ResponseMenu> menuItems;
  final List<ResponseMember> responseMembers;
  final List<ResponseGuest> responseGuests;
  final int eventID;
  final Function(EventOrderParams params) onPressedSubmit;
  const AddEventOrderDialogBox({
    super.key,
    required this.menuItems,
    required this.eventID,
    required this.responseMembers,
    required this.responseGuests,
    required this.onPressedSubmit,
  });

  @override
  State<AddEventOrderDialogBox> createState() => _AddEventOrderDialogBoxState();
}

class _AddEventOrderDialogBoxState extends State<AddEventOrderDialogBox> {
  PaymentSource paymentSource = PaymentSource.member;
  bool isNotSelected = false;
  int? selectedMemberID;
  int? selectedGuestID;

  final selectedItems = <ResponseMenu>[];

  @override
  Widget build(BuildContext context) {
    return AppCustomWidgetDialogBox(
      title: 'Add Orders',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Ordered By',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const Gap(6),
              AppTab(
                tabs: [
                  TabTile(
                    title: 'Member',
                    isSelected: paymentSource.isMemberSelected,
                    onTap: () {
                      paymentSource = PaymentSource.member;
                      selectedGuestID = null;
                      selectedMemberID = null;
                      setState(() {});
                    },
                  ),
                  TabTile(
                    title: 'Guest',
                    isSelected: paymentSource.isGuestSelected,
                    onTap: () {
                      paymentSource = PaymentSource.guest;
                      selectedGuestID = null;
                      selectedMemberID = null;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ),
          Gap(4),
          if (paymentSource == PaymentSource.member)
            AppDropDownButton<ResponseMember>(
              hint: 'Select a Member',
              showWarning: isNotSelected,
              value: widget.responseMembers.firstWhereOrNull((element) {
                return element.id == selectedMemberID;
              }),
              onChanged: (value) {
                if (value != null) {
                  selectedMemberID = value.id;
                  selectedGuestID = null;
                  isNotSelected = false;
                  setState(() {});
                }
              },
              items: widget.responseMembers.map((e) {
                return DropdownMenuItem<ResponseMember>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
            ),
          if (paymentSource == PaymentSource.guest)
            AppDropDownButton<ResponseGuest>(
              hint: 'Select a Guest',
              showWarning: isNotSelected,
              value: widget.responseGuests.firstWhereOrNull((element) {
                return element.id == selectedGuestID;
              }),
              onChanged: (value) {
                if (value != null) {
                  selectedGuestID = value.id;
                  selectedMemberID = null;
                  isNotSelected = false;
                  setState(() {});
                }
              },
              items: widget.responseGuests.map((e) {
                return DropdownMenuItem<ResponseGuest>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
            ),
          Gap(20),
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
                      'Please select...',
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
        if (selectedGuestID == null && selectedMemberID == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        final params = EventOrderParams(
          id: null,
          eventID: widget.eventID,
          memberID: selectedMemberID,
          guestID: selectedGuestID,
          menuItemIDs: selectedItems.map((e) => e.id).toList(),
        );

        widget.onPressedSubmit.call(params);
        context.pop();
      },
    );
  }
}
