import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/app_wrap_builder.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class AddEventTransactionDialogBox extends StatefulWidget {
  final int eventID;
  final Function(List<TransactionParams> transactions) onPressedSubmit;
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
  bool isNotSelected = false;
  bool isPaidSourceNotSelected = false;
  int? selectedMemberID;
  final selectedGuestIDs = <int>[];
  final transactions = <TransactionParams>[];

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
      title: S.current.eventDetails_addEventTransaction,
      children: [
        AppDropDownButton<TransactionType>(
          label: S.current.dropDownButton_label_transactionType,
          hint: S.current.dropDownButton_hint_selectType,
          showWarning: isNotSelected,
          value: TransactionType.values.firstWhereOrNull((element) {
            return element.name == transactionType?.name;
          }),
          onChanged: (value) {
            if (value != null) {
              transactionType = value;
              selectedMemberID = null;
              selectedGuestIDs.clear();
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
        if (transactionType?.isIncome ?? false) ...[
          AppDropDownButton<ResponseGuest>(
            label: S.current.dropDownButton_label_guests,
            hint: S.current.dropDownButton_hint_selectGuest,
            showWarning: isPaidSourceNotSelected,
            value: null,
            onChanged: (value) {
              if (value != null) {
                selectedGuestIDs.add(value.id);
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
          if (selectedGuestIDs.isNotEmpty) ...[
            Gap(10),
            AppWrapBuilder(
              selectedGuestIDs.map((e) {
                final guest = widget.responseGuests.firstWhere((element) {
                  return element.id == e;
                });

                return GestureDetector(
                  onTap: () {
                    selectedGuestIDs.remove(e);
                    setState(() {});
                  },
                  child: Text(
                    guest.name,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              }).toList(),
            ),
          ],

          Gap(20),
        ],
        if (transactionType?.isExpense ?? false) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppDropDownButton<ResponseMember>(
                  label:
                      '${S.current.dropDownButton_label_members} ${S.current.textField_label_optional}',
                  hint: S.current.dropDownButton_hint_selectMember,
                  value: widget.responseMembers.firstWhereOrNull((element) {
                    return element.id == selectedMemberID;
                  }),
                  onChanged: (value) {
                    if (value != null) {
                      selectedMemberID = value.id;
                      selectedGuestIDs.clear();
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
              ),
              IconButton(
                onPressed: () {
                  selectedMemberID = null;
                  selectedGuestIDs.clear();
                  isPaidSourceNotSelected = false;
                  setState(() {});
                },
                icon: Icon(Icons.clear_rounded),
              ),
            ],
          ),
          Gap(20),
        ],

        Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                label: S.current.textField_label_amount,
                hint: '10,000,000',
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [PriceInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
              Gap(20),
              AppTextField(
                label: S.current.textField_label_date,
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  PickDate.yearMonthAndDay(
                    context,
                    startFrom: DateTime.now().toJalali().year - 1,
                    endTo: DateTime.now().toJalali().year,
                    initDate: selectedDate,
                    onSubmit: (pickedDate, formattedDate) {
                      selectedDate = pickedDate;
                      dateController.text = formattedDate;
                    },
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.validator_required;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Gap(20),
        AppTextField(
          label:
              '${S.current.textField_label_description} ${S.current.textField_label_optional}',
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

        if (transactionType?.isIncome == true && selectedGuestIDs.isEmpty) {
          isPaidSourceNotSelected = true;
          setState(() {});
          return;
        }

        if (transactionType?.isIncome == true && selectedGuestIDs.isNotEmpty) {
          for (var guestId in selectedGuestIDs) {
            transactions.add(
              TransactionParams(
                id: null,
                eventID: widget.eventID,
                transactionType: transactionType!,
                amount: AmountHelper.formattedPriceToInteger(
                  amountController.text,
                ),
                description: descriptionController.text,
                transactionDate: selectedDate!,
                attachment: null,
                guestID: guestId,
                memberID: null,
                hasPermissionDeleteOrder: false,
              ),
            );
          }
        }

        if (transactionType?.isExpense == true) {
          transactions.add(
            TransactionParams(
              id: null,
              eventID: widget.eventID,
              transactionType: transactionType!,
              amount: AmountHelper.formattedPriceToInteger(
                amountController.text,
              ),
              description: descriptionController.text,
              transactionDate: selectedDate!,
              attachment: null,
              guestID: null,
              memberID: selectedMemberID,
              hasPermissionDeleteOrder: false,
            ),
          );
        }

        widget.onPressedSubmit(transactions);
        context.pop();
      },
    );
  }
}
