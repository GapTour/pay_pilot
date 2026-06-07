// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/member_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class EditMemberDialogBox extends StatefulWidget {
  final ResponseMember member;
  final Function(MemberParams member) onPressedSubmit;
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
  final TextEditingController birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int memberID;
  late DateTime? selectedJainAtDate;
  late DateTime? selectedBirthdayDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    joinAtDateController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    memberID = widget.member.id;
    nameController.text = widget.member.name;
    descriptionController.text = widget.member.description ?? '';
    selectedJainAtDate = widget.member.joinAt;
    if (selectedJainAtDate != null) {
      joinAtDateController.text =
          selectedJainAtDate!.formattedToJalali_yearMonth;
    }
    selectedBirthdayDate = widget.member.birthday;
    if (selectedBirthdayDate != null) {
      birthdayController.text =
          selectedBirthdayDate!.formattedToJalali_yearMonthDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: S.current.member_editMember,
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_name,
            hint: S.current.textField_hint_mahdiyar,
            autoFocus: true,
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.current.validator_required;
              }
              return null;
            },
          ),
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_joinAt,
          hint: DateTime.now().formattedToJalali_yearMonth,
          controller: joinAtDateController,
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: (focusNode) async {
            PickDate.yearAndMonth(
              context,
              startFrom: 1380,
              endTo: DateTime.now().toJalali().year,
              initDate: selectedJainAtDate ?? widget.member.joinAt,
              onSubmit: (pickedDate, formattedDate) {
                selectedJainAtDate = pickedDate;
                joinAtDateController.text = formattedDate;
              },
            );
          },
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_birthday,
          hint: DateTime.now().formattedToJalali_yearMonthDay,
          controller: birthdayController,
          keyboardType: TextInputType.datetime,
          readOnly: true,
          onTap: (focusNode) async {
            PickDate.yearMonthAndDay(
              context,
              startFrom: 1330,
              endTo: DateTime.now().toJalali().year,
              initDate: selectedBirthdayDate ?? widget.member.joinAt,
              onSubmit: (pickedDate, formattedDate) {
                selectedBirthdayDate = pickedDate;
                birthdayController.text = formattedDate;
              },
            );
          },
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
        final member = MemberParams(
          id: memberID,
          name: nameController.text,
          joinAt: selectedJainAtDate,
          birthday: selectedBirthdayDate,
          description: descriptionController.text.isNotEmpty
              ? descriptionController.text
              : null,
          isActive: true,
          profileImage: null,
        );
        widget.onPressedSubmit(member);
        context.pop();
      },
    );
  }
}
