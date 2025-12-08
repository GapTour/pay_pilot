// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';

class AddMemberDialogBox extends StatefulWidget {
  final Function(MemberParams member) onPressedSubmit;
  const AddMemberDialogBox({super.key, required this.onPressedSubmit});

  @override
  State<AddMemberDialogBox> createState() => _AddMemberDialogBoxState();
}

class _AddMemberDialogBoxState extends State<AddMemberDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController joinAtDateController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? selectedJainAtDate;
  DateTime? selectedBirthdayDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    joinAtDateController.dispose();
    birthdayController.dispose();
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
          hint: DateTime.now().formattedToJalali_yearMonth,
          controller: joinAtDateController,
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: (focusNode) async {
            PickDate.yearAndMonth(
              context,
              initDate: selectedJainAtDate,
              onSubmit: (pickedDate, formattedDate) {
                selectedJainAtDate = pickedDate;
                joinAtDateController.text = formattedDate;
              },
            );
          },
        ),
        AppTextField(
          label: 'Birthday',
          hint: DateTime.now().formattedToJalali_yearMonth,
          controller: birthdayController,
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: (focusNode) async {
            PickDate.yearMonthAndDay(
              context,
              initDate: selectedBirthdayDate,
              onSubmit: (pickedDate, formattedDate) {
                selectedBirthdayDate = pickedDate;
                birthdayController.text = formattedDate;
              },
            );
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
        final member = MemberParams(
          id: null,
          name: nameController.text,
          joinAt: selectedJainAtDate,
          birthday: selectedBirthdayDate,
          isActive: true,
          profileImage: null,
          description: descriptionController.text,
        );
        widget.onPressedSubmit(member);
        context.pop();
      },
    );
  }
}
