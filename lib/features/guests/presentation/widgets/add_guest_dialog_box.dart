// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class AddGuestDialogBox extends StatefulWidget {
  final Function(GuestParams guest) onPressedSubmit;
  const AddGuestDialogBox({super.key, required this.onPressedSubmit});

  @override
  State<AddGuestDialogBox> createState() => _AddGuestDialogBoxState();
}

class _AddGuestDialogBoxState extends State<AddGuestDialogBox> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController telegramIdController = TextEditingController();
  final TextEditingController instagramIdController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? selectedBirthdayDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    telegramIdController.dispose();
    instagramIdController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: S.current.guest_addGuest,
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
          label: S.current.textField_label_phone,
          hint: S.current.textField_hint_phone,
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_telegramId,
          hint: S.current.textField_hint_id,
          controller: telegramIdController,
          keyboardType: TextInputType.emailAddress,
        ),
        Gap(20),
        AppTextField(
          label: S.current.textField_label_instagramId,
          hint: S.current.textField_hint_id,
          controller: instagramIdController,
          keyboardType: TextInputType.emailAddress,
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
              initDate: selectedBirthdayDate,
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
        final guest = GuestParams(
          id: null,
          name: nameController.text,
          telegramID: telegramIdController.text.isNotEmpty
              ? telegramIdController.text
              : null,
          instagramID: instagramIdController.text.isNotEmpty
              ? instagramIdController.text
              : null,
          phone: phoneController.text.isNotEmpty ? phoneController.text : null,
          birthday: selectedBirthdayDate,
          isActive: true,
          profileImage: null,
          description: descriptionController.text.isNotEmpty
              ? descriptionController.text
              : null,
        );
        widget.onPressedSubmit(guest);
        context.pop();
      },
    );
  }
}
