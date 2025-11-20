import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/models/transaction_model.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/event_details/data/transaction_edit_form.dart';

class EditEventTransactionDialogBox extends StatefulWidget {
  final TransactionModel transaction;
  final int eventID;
  final Function(TransactionEditForm transaction) onPressedSubmit;
  const EditEventTransactionDialogBox({
    super.key,
    required this.transaction,
    required this.eventID,
    required this.onPressedSubmit,
  });

  @override
  State<EditEventTransactionDialogBox> createState() =>
      _EditEventTransactionDialogBoxState();
}

class _EditEventTransactionDialogBoxState
    extends State<EditEventTransactionDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late TransactionType transactionType;
  late DateTime? selectedDate;
  bool isNotSelected = false;

  final transactionTypes = [TransactionType.expense, TransactionType.income];

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    descriptionController.text = widget.transaction.description ?? '';
    amountController.text = AmountHelper.integerToFormattedPrice(
      widget.transaction.amount,
    );
    dateController.text =
        widget.transaction.date.formattedToJalali_yearMonthDay;
    selectedDate = widget.transaction.date;
    transactionType = widget.transaction.transactionType;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Transaction',
      children: [
        AppDropDownButton<TransactionType>(
          label: 'Transaction Type',
          hint: 'Select a type',
          showWarning: isNotSelected,
          value: transactionTypes.firstWhereOrNull((element) {
            return element.name == transactionType.name;
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
              AppTextField(
                label: 'Date',
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  PickDate.yearMonthAndDay(
                    context,
                    initDate: selectedDate ?? widget.transaction.date,
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
        AppTextField(
          label: 'Description (optional)',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final transaction = TransactionEditForm(
          id: widget.transaction.id,
          eventID: widget.eventID,
          transactionType: transactionType,
          amount: AmountHelper.formattedPriceToInteger(amountController.text),
          description: descriptionController.text,
          date: selectedDate!,
        );
        widget.onPressedSubmit(transaction);
        context.pop();
      },
    );
  }
}
