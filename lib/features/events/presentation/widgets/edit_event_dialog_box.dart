import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/models/event_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/events/data/models/event_edit_form.dart';

class EditEventDialogBox extends StatefulWidget {
  final EventModel eventDetails;
  final List<Team> teams;
  final Function(EventEditForm event) onPressedSubmit;
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
    teamID = widget.eventDetails.team.id;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Event',
      children: [
        AppDropDownButton<Team>(
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
            return DropdownMenuItem<Team>(value: e, child: Text(e.title));
          }).toList(),
        ),
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
              AppTextField(
                label: 'Date',
                hint: DateTime.now().formattedToJalali_yearMonthDay,
                controller: dateController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: (focusNode) async {
                  PickDate.yearMonthAndDay(
                    context,
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
        final event = EventEditForm(
          id: eventID,
          title: titleController.text,
          description: descriptionController.text,
          date: selectedDate!,
          teamID: teamID,
        );
        widget.onPressedSubmit(event);
        context.pop();
      },
    );
  }
}
