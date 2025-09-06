// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/members/data/member_form.dart';

class AddMemberDialogBox extends StatefulWidget {
  final Member? member;
  final Function(MemberForm member) onPressedSubmit;
  const AddMemberDialogBox({
    super.key,
    this.member,
    required this.onPressedSubmit,
  });

  @override
  State<AddMemberDialogBox> createState() => _AddMemberDialogBoxState();
}

class _AddMemberDialogBoxState extends State<AddMemberDialogBox> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int? memberID;

  @override
  void dispose() {
    descriptionController.dispose();
    nameController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.member != null) {
      memberID = widget.member!.id;
      nameController.text = widget.member!.name;
      percentageController.text = widget.member!.percentage.toString();
      descriptionController.text = widget.member!.description ?? '';
    } else {
      memberID = null;
    }
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
              Text('Add New Member', style: TextStyle(fontSize: 22)),
              Gap(18),

              Form(
                key: formKey,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: AppTextField(
                        label: 'Name',
                        hint: 'Mahdiyar',
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
                    Gap(8),
                    Flexible(
                      child: AppTextField(
                        label: 'Ratio',
                        hint: '10',
                        prefixIcon: Icons.percent,
                        controller: percentageController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
                        final member = MemberForm(
                          id: memberID,
                          name: nameController.text,
                          percentage: double.parse(percentageController.text),
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
