// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/teams/data/team_edit_form.dart';

class EditTeamDialogBox extends StatefulWidget {
  final Team team;
  final Function(TeamEditForm team) onPressedSubmit;
  const EditTeamDialogBox({
    super.key,
    required this.team,
    required this.onPressedSubmit,
  });

  @override
  State<EditTeamDialogBox> createState() => _EditTeamDialogBoxState();
}

class _EditTeamDialogBoxState extends State<EditTeamDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int teamID;

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    teamID = widget.team.id;
    titleController.text = widget.team.title;
    descriptionController.text = widget.team.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 507,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Team', style: TextStyle(fontSize: 22)),
              Gap(18),

              Form(
                key: formKey,
                child: AppTextField(
                  label: 'Title',
                  hint: 'Movie Analyze',
                  controller: titleController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
              ),
              Gap(12),

              AppTextField(
                label: 'Description (optional)',
                controller: descriptionController,
                minLines: 3,
                maxLines: 4,
              ),
              Spacer(),
              Gap(16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        final member = TeamEditForm(
                          id: teamID,
                          title: titleController.text,
                          description: descriptionController.text,
                        );
                        widget.onPressedSubmit(member);
                        context.pop();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  Gap(8),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
