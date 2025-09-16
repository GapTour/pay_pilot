// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/members/data/member_form.dart';

class AddMemberDialogBox extends StatefulWidget {
  final Function(MemberForm member) onPressedSubmit;
  const AddMemberDialogBox({super.key, required this.onPressedSubmit});

  @override
  State<AddMemberDialogBox> createState() => _AddMemberDialogBoxState();
}

class _AddMemberDialogBoxState extends State<AddMemberDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController joinAtDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int? memberID;
  DateTime? selectedDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    joinAtDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Add New Member',
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: 'Name',
            hint: 'Mahdiyar',
            autoFocus: true,
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              return null;
            },
          ),
        ),
        AppTextField(
          label: 'Join at',
          hint: DateFormat.yMMMEd().format(DateTime.now()),
          controller: joinAtDateController,
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
              joinAtDateController.text = DateFormat.yMMMEd().format(
                selectedDate!,
              );
            }
          },
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
        final member = MemberForm(
          name: nameController.text,
          joinAt: selectedDate,
          description: descriptionController.text,
        );
        widget.onPressedSubmit(member);
        context.pop();
      },
    );
  }
}
