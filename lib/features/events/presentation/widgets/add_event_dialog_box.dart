import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/format_date_to_persian_calendar.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/core/widgets/pick_date.dart';
import 'package:pay_pilot/features/events/data/event_form.dart';

class AddEventDialogBox extends StatefulWidget {
  final List<Team> teams;
  final Function(EventForm event) onPressedSubmit;
  const AddEventDialogBox({
    super.key,
    required this.teams,
    required this.onPressedSubmit,
  });

  @override
  State<AddEventDialogBox> createState() => _AddEventDialogBoxState();
}

class _AddEventDialogBoxState extends State<AddEventDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int? teamID;
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
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Add New Event',
      children: [
        AppDropDownButton<Team>(
          label: 'Teams',
          hint: 'Select a team',
          showWarning: isNotSelected,
          value: widget.teams.firstWhereOrNull(
            (element) => element.id == teamID,
          ),
          onChanged: (value) {
            teamID = value?.id;
            setState(() {});
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
                    initDate: selectedDate,
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
        if (teamID == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        final event = EventForm(
          title: titleController.text,
          description: descriptionController.text,
          date: selectedDate!,
          teamID: teamID!,
        );
        widget.onPressedSubmit(event);
        context.pop();
      },
    );
  }
}
