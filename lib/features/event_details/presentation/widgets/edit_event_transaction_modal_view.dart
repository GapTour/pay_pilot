import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/transaction_params.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_modal_list_view_skin.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_transaction.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class EditEventTransactionModalView extends StatefulWidget {
  final ResponseEventTransaction transaction;
  final List<ResponseMember> responseMembers;
  final List<ResponseGuest> responseGuests;
  final int eventID;
  final Function(TransactionParams transaction) onPressedSubmit;
  const EditEventTransactionModalView({
    super.key,
    required this.transaction,
    required this.responseMembers,
    required this.responseGuests,
    required this.eventID,
    required this.onPressedSubmit,
  });

  @override
  State<EditEventTransactionModalView> createState() =>
      _EditEventTransactionModalViewState();
}

class _EditEventTransactionModalViewState
    extends State<EditEventTransactionModalView> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late TransactionType transactionType;
  late DateTime? selectedDate;
  late DebounceHelper debounce;
  bool isNotSelected = false;
  bool isPaidSourceNotSelected = false;
  int? selectedMemberID;
  int? selectedGuestID;

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    debounce.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

    descriptionController.text = widget.transaction.description ?? '';
    if (widget.transaction.amount != 0) {
      amountController.text = AmountHelper.integerToFormattedPrice(
        widget.transaction.amount,
      );
    }
    dateController.text =
        widget.transaction.date.formattedToJalali_yearMonthDay;
    selectedDate = widget.transaction.date;
    transactionType = widget.transaction.transactionType;

    if (widget.transaction.paidByGuest != null) {
      selectedGuestID = widget.transaction.paidByGuest;
    } else if (widget.transaction.paidByMember != null) {
      selectedMemberID = widget.transaction.paidByMember;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppModalListViewSkin(
      children: [
        AppDropDownButton<TransactionType>(
          label: S.current.dropDownButton_label_transactionType,
          hint: S.current.dropDownButton_hint_selectType,
          showWarning: isNotSelected,
          value: TransactionType.values.firstWhereOrNull((element) {
            return element.name == transactionType.name;
          }),
          onChanged: (value) {
            if (value != null) {
              transactionType = value;
              selectedMemberID = null;
              selectedGuestID = null;
              setState(() {});
            }
          },
          items: TransactionType.values.map((e) {
            return DropdownMenuItem<TransactionType>(
              value: e,
              child: Text(
                e.isIncome
                    ? S.current.contentTitle_income
                    : S.current.contentTitle_expense,
              ),
            );
          }).toList(),
        ),
        Gap(20),
        if (transactionType.isIncome) ...[
          AppDropDownButton<ResponseGuest>(
            label: S.current.dropDownButton_label_guests,
            hint: S.current.dropDownButton_hint_selectGuest,
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
        ],
        if (transactionType.isExpense) ...[
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
              ),
              IconButton(
                onPressed: () {
                  selectedMemberID = null;
                  selectedGuestID = null;
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
                onChange: (value) {
                  debounce.call(() {
                    final isZero =
                        value ==
                        amountController.text.replaceAll('-', '').trim();

                    if (isZero) amountController.clear();
                  });
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
                    initDate: selectedDate ?? widget.transaction.date,
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
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;

        if (transactionType.isIncome && selectedGuestID == null) {
          isPaidSourceNotSelected = true;
          setState(() {});
          return;
        }
        final transaction = TransactionParams(
          id: widget.transaction.id,
          eventID: widget.eventID,
          transactionType: transactionType,
          amount: AmountHelper.formattedPriceToInteger(amountController.text),
          description: descriptionController.text,
          transactionDate: selectedDate!,
          attachment: null,
          memberID: selectedMemberID,
          guestID: selectedGuestID,
          hasPermissionDeleteOrder: false,
        );
        widget.onPressedSubmit(transaction);
        context.pop();
      },
    );
  }
}
