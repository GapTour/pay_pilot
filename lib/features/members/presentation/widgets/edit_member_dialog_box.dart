// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/members/data/member_editing_form.dart';

class EditMemberDialogBox extends StatefulWidget {
  final Member member;
  final Function(MemberEditingForm member) onPressedSubmit;
  const EditMemberDialogBox({
    super.key,
    required this.member,
    required this.onPressedSubmit,
  });

  @override
  State<EditMemberDialogBox> createState() => _EditMemberDialogBoxState();
}

class _EditMemberDialogBoxState extends State<EditMemberDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController joinAtDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int memberID;
  late DateTime? selectedDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    joinAtDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    memberID = widget.member.id;
    nameController.text = widget.member.name;
    joinAtDateController.text = widget.member.joinAt == null
        ? ''
        : widget.member.joinAt!.formattedToJalali_yearMonth;
    descriptionController.text = widget.member.description ?? '';
    selectedDate = widget.member.joinAt;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Member',
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
              initDate: selectedDate ?? widget.member.joinAt,
              onSubmit: (pickedDate, formattedDate) {
                selectedDate = pickedDate;
                joinAtDateController.text = formattedDate;
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
        final member = MemberEditingForm(
          id: memberID,
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
