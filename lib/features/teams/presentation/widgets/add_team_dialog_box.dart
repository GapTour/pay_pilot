import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/team_params.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';

class AddTeamDialogBox extends StatefulWidget {
  final Function(TeamParams team) onPressedSubmit;
  const AddTeamDialogBox({super.key, required this.onPressedSubmit});

  @override
  State<AddTeamDialogBox> createState() => _AddTeamDialogBoxState();
}

class _AddTeamDialogBoxState extends State<AddTeamDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Add New Team',
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: 'Title',
            hint: 'Movie Analyze',
            autoFocus: true,
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
        Gap(20),
        AppTextField(
          label: 'Description (optional)',
          controller: descriptionController,
          minLines: 3,
          maxLines: 4,
        ),
        Gap(20),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final team = TeamParams(
          id: null,
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
