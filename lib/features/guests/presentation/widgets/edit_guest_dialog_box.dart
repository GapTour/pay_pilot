// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/guest_params.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/guests/data/models/response_guest.dart';

class EditGuestDialogBox extends StatefulWidget {
  final ResponseGuest guest;
  final Function(GuestParams guest) onPressedSubmit;
  const EditGuestDialogBox({
    super.key,
    required this.guest,
    required this.onPressedSubmit,
  });

  @override
  State<EditGuestDialogBox> createState() => _EditGuestDialogBoxState();
}

class _EditGuestDialogBoxState extends State<EditGuestDialogBox> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController telegramIdController = TextEditingController();
  final TextEditingController instagramIdController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int memberID;
  late DateTime? selectedBirthdayDate;

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
  void initState() {
    super.initState();

    memberID = widget.guest.id;
    nameController.text = widget.guest.name;
    if (widget.guest.description != null) {
      descriptionController.text = widget.guest.description!;
    }
    selectedBirthdayDate = widget.guest.birthday;
    if (selectedBirthdayDate != null) {
      birthdayController.text =
          selectedBirthdayDate!.formattedToJalali_yearMonthDay;
    }
    if (widget.guest.instagramID != null) {
      instagramIdController.text = widget.guest.instagramID!;
    }
    if (widget.guest.telegramID != null) {
      telegramIdController.text = widget.guest.telegramID!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Guest',
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
          id: memberID,
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
