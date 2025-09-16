import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/database/tables/event_transactions.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_form.dart';

class AddEventTransactionDialogBox extends StatefulWidget {
  final int eventID;
  final Function(TransactionForm transaction) onPressedSubmit;
  const AddEventTransactionDialogBox({
    super.key,
    required this.eventID,
    required this.onPressedSubmit,
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

  final transactionTypes = [TransactionType.expense, TransactionType.income];

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
        AppDropDownButton<TransactionType>(
          label: 'Transaction Type',
          hint: 'Select a type',
          showWarning: isNotSelected,
          value: transactionTypes.firstWhereOrNull((element) {
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
                hint: DateFormat.yMMMEd().format(DateTime.now()),
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    dateController.text = DateFormat.yMMMEd().format(
                      selectedDate!,
                    );
                  }
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
        if (transactionType == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        final transaction = TransactionForm(
          eventID: widget.eventID,
          transactionType: transactionType!,
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
