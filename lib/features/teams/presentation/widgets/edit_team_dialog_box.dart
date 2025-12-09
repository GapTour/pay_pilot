// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class EditTeamDialogBox extends StatefulWidget {
  final ResponseTeam team;
  final Function(TeamParams team) onPressedSubmit;
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
    if (widget.team.description != null) {
      descriptionController.text = widget.team.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Team',
      children: [
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
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final team = TeamParams(
          id: teamID,
          title: titleController.text,
          description: descriptionController.text.isNotEmpty
              ? descriptionController.text
              : null,
          isActive: true,
        );
        widget.onPressedSubmit(team);
        context.pop();
      },
    );
  }
}
