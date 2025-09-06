// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/helpers/amount_helper.dart';
import 'package:pay_pilot/core/utils/resource/input_formatter.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/incomes/data/income_form.dart';

class AddIncomeDialogBox extends StatefulWidget {
  final Income? income;
  final Function(IncomeForm income) onPressedSubmit;
  const AddIncomeDialogBox({
    super.key,
    this.income,
    required this.onPressedSubmit,
  });

  @override
  State<AddIncomeDialogBox> createState() => _AddIncomeDialogBoxState();
}

class _AddIncomeDialogBoxState extends State<AddIncomeDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int? incomeID;
  DateTime? selectedDate;

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.income != null) {
      incomeID = widget.income!.id;
      titleController.text = widget.income!.title;
      amountController.text = widget.income!.amount.toString();
      descriptionController.text = widget.income!.description ?? '';
      dateController.text = DateFormat.MMMMEEEEd().format(widget.income!.date);
      selectedDate = widget.income!.date;
    } else {
      incomeID = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 620,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add New Income', style: TextStyle(fontSize: 22)),
              Gap(18),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: 'Title',
                      hint: 'Cast Away Movie',
                      controller: titleController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*Required';
                        }
                        return null;
                      },
                    ),
                    Gap(12),
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
                    Gap(12),
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
              Gap(12),

              AppTextField(
                label: 'Description (optional)',
                controller: descriptionController,
                minLines: 3,
                maxLines: 4,
              ),
              Spacer(),
              Gap(16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        final income = IncomeForm(
                          id: incomeID,
                          title: titleController.text,
                          amount: AmountHelper.formattedPriceToInteger(
                            amountController.text,
                          ),
                          description: descriptionController.text,
                          date: selectedDate!,
                        );
                        widget.onPressedSubmit(income);
                        context.pop();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  Gap(8),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
