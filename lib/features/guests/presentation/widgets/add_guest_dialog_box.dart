// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';

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
  final formKey = GlobalKey<FormState>();
  DateTime? selectedBirthdayDate;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    telegramIdController.dispose();
    instagramIdController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Add New Guest',
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
          label: 'Telegram ID',
          hint: '@mahdiyarz',
          controller: telegramIdController,
          keyboardType: TextInputType.emailAddress,
        ),
        AppTextField(
          label: 'Instagram ID',
          hint: '@mahdiyarz',
          controller: instagramIdController,
          keyboardType: TextInputType.emailAddress,
        ),
        AppTextField(
          label: 'Birthday',
          hint: DateTime.now().formattedToJalali_yearMonthDay,
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
        final guest = GuestParams(
          id: null,
          name: nameController.text,
          telegramID: telegramIdController.text.isNotEmpty
              ? telegramIdController.text
              : null,
          instagramID: instagramIdController.text.isNotEmpty
              ? instagramIdController.text
              : null,
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
