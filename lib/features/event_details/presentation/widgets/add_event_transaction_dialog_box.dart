import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/enums/payment_source.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_tab.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class AddEventTransactionDialogBox extends StatefulWidget {
  final int eventID;
  final Function(TransactionParams transaction) onPressedSubmit;
  final List<ResponseMember> responseMembers;
  final List<ResponseGuest> responseGuests;
  const AddEventTransactionDialogBox({
    super.key,
    required this.eventID,
    required this.onPressedSubmit,
    required this.responseMembers,
    required this.responseGuests,
  });

  @override
  State<AddEventTransactionDialogBox> createState() =>
      _AddEventTransactionDialogBoxState();
}

class _AddEventTransactionDialogBoxState
    extends State<AddEventTransactionDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TransactionType? transactionType;
  DateTime? selectedDate;
  PaymentSource paymentSource = PaymentSource.guest;
  bool isNotSelected = false;
  bool isPaidSourceNotSelected = false;
  int? selectedMemberID;
  int? selectedGuestID;

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Add New Transaction',
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Paid By',
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
        if (isPaidSourceNotSelected)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '*Please select a payment source',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          )
        else
          Gap(4),
        if (paymentSource == PaymentSource.member)
          AppDropDownButton<ResponseMember>(
            hint: 'Select a Member',
            showWarning: isPaidSourceNotSelected,
            value: widget.responseMembers.firstWhereOrNull((element) {
              return element.id == selectedMemberID;
            }),
            onChanged: (value) {
              if (value != null) {
                selectedMemberID = value.id;
                selectedGuestID = null;
                isPaidSourceNotSelected = false;
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
            showWarning: isPaidSourceNotSelected,
            value: widget.responseGuests.firstWhereOrNull((element) {
              return element.id == selectedGuestID;
            }),
            onChanged: (value) {
              if (value != null) {
                selectedGuestID = value.id;
                selectedMemberID = null;
                isPaidSourceNotSelected = false;
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
        AppDropDownButton<TransactionType>(
          label: 'Transaction Type',
          hint: 'Select a type',
          showWarning: isNotSelected,
          value: TransactionType.values.firstWhereOrNull((element) {
            return element.name == transactionType?.name;
          }),
          onChanged: (value) {
            if (value != null) {
              transactionType = value;
              setState(() {});
            }
          },
          items: TransactionType.values.map((e) {
            return DropdownMenuItem<TransactionType>(
              value: e,
              child: Text(e.name),
            );
          }).toList(),
        ),
        Gap(20),
        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Amount',
                hint: '10,000,000',
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
              Gap(20),
              AppTextField(
                label: 'Date',
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  PickDate.yearMonthAndDay(
                    context,
                    initDate: selectedDate,
                    onSubmit: (pickedDate, formattedDate) {
                      selectedDate = pickedDate;
                      dateController.text = formattedDate;
                    },
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Gap(20),
        AppTextField(
          label: 'Description (optional)',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
        Gap(85),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        if (transactionType == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        if (selectedGuestID == null && selectedMemberID == null) {
          isPaidSourceNotSelected = true;
          setState(() {});
          return;
        }
        final transaction = TransactionParams(
          id: null,
          eventID: widget.eventID,
          transactionType: transactionType!,
          amount: AmountHelper.formattedPriceToInteger(amountController.text),
          description: descriptionController.text,
          transactionDate: selectedDate!,
          attachment: null,
          guestID: selectedGuestID,
          memberID: selectedMemberID,
          hasPermissionDeleteOrder: false,
        );
        widget.onPressedSubmit(transaction);
        context.pop();
      },
    );
  }
}
