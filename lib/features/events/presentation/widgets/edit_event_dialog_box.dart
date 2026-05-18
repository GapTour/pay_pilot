import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/event_params.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/events/data/models/response_event.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';

class EditEventDialogBox extends StatefulWidget {
  final ResponseEvent eventDetails;
  final List<ResponseTeam> teams;
  final Function(EventParams event) onPressedSubmit;
  const EditEventDialogBox({
    super.key,
    required this.eventDetails,
    required this.teams,
    required this.onPressedSubmit,
  });

  @override
  State<EditEventDialogBox> createState() => _EditEventDialogBoxState();
}

class _EditEventDialogBoxState extends State<EditEventDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int eventID;
  late int teamID;
  DateTime? selectedDate;
  bool isNotSelected = false;

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    eventID = widget.eventDetails.id;
    titleController.text = widget.eventDetails.title;
    descriptionController.text = widget.eventDetails.description ?? '';
    dateController.text =
        widget.eventDetails.date.formattedToJalali_yearMonthDay;
    selectedDate = widget.eventDetails.date;
    teamID = widget.eventDetails.teamID;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Event',
      children: [
        AppDropDownButton<ResponseTeam>(
          label: 'Teams',
          hint: 'Select a team',
          showWarning: isNotSelected,
          value: widget.teams.firstWhereOrNull(
            (element) => element.id == teamID,
          ),
          onChanged: (value) {
            if (value != null) {
              teamID = value.id;
              setState(() {});
            }
          },
          items: widget.teams.map((e) {
            return DropdownMenuItem<ResponseTeam>(
              value: e,
              child: Text(e.title),
            );
          }).toList(),
        ),
        Gap(20),
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
              Gap(20),
              AppTextField(
                label: 'Date',
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  PickDate.yearMonthAndDay(
                    context,
                    startFrom: DateTime.now().toJalali().year - 1,
                    endTo: DateTime.now().toJalali().year,
                    initDate: selectedDate ?? widget.eventDetails.date,
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
              Gap(20),
            ],
          ),
        ),
        AppTextField(
          label: 'Description (optional)',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
        Gap(85),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final event = EventParams(
          id: eventID,
          title: titleController.text,
          description: descriptionController.text.isEmpty
              ? null
              : descriptionController.text,
          date: selectedDate!,
          teamID: teamID,
          isActive: true,
        );
        widget.onPressedSubmit(event);
        context.pop();
      },
    );
  }
}
