import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/models/team_member_details_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/team_members/data/team_members_edit_form.dart';

class EditRatioDialogBox extends StatefulWidget {
  final TeamMemberDetailsModel teamMember;
  final Team team;
  final List<Member> members;
  final Map<int, double> addedMembers;
  final Function(TeamMembersEditForm teamMember) onPressedSubmit;
  const EditRatioDialogBox({
    super.key,
    required this.teamMember,
    required this.team,
    required this.members,
    required this.onPressedSubmit,
    required this.addedMembers,
  });

  @override
  State<EditRatioDialogBox> createState() => _EditRatioDialogBoxState();
}

class _EditRatioDialogBoxState extends State<EditRatioDialogBox> {
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController teamController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formDropDownKey = GlobalKey<FormState>();
  final List<Member> notAddedMembers = [];
  double remindedRatio = 100;
  late int memberID;
  late int ratioID;
  bool isNotSelected = false;

  @override
  void dispose() {
    ratioController.dispose();
    teamController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    teamController.text = widget.team.title;

    ratioID = widget.teamMember.id;
    memberID = widget.teamMember.member.id;
    ratioController.text = widget.teamMember.ratio.toString();

    notAddedMembers.add(widget.teamMember.member);
    remindedRatio = remindedRatio + widget.teamMember.ratio;

    widget.members.fold<List<Member>>([], (previousValue, element) {
      if (!widget.addedMembers.containsKey(element.id)) {
        notAddedMembers.add(element);
      }
      remindedRatio =
          remindedRatio -
          (widget.addedMembers.entries
                  .firstWhereOrNull((map) => map.key == element.id)
                  ?.value ??
              0);

      return previousValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Team\'s Member',
      children: [
        AppTextField(label: 'Team', controller: teamController, readOnly: true),
        AppDropDownButton<Member>(
          label: 'Members',
          hint: 'Select a member',
          showWarning: isNotSelected,
          value: widget.members.firstWhereOrNull(
            (element) => element.id == memberID,
          ),
          onChanged: (value) {
            if (value != null) {
              memberID = value.id;
              setState(() {});
            }
          },
          items: notAddedMembers.map((e) {
            return DropdownMenuItem<Member>(value: e, child: Text(e.name));
          }).toList(),
        ),
        Form(
          key: formKey,
          child: AppTextField(
            label: 'Ratio',
            hint: '${remindedRatio.round()}',
            readOnly: remindedRatio == 0,
            prefixIcon: Icons.percent,
            controller: ratioController,
            keyboardType: TextInputType.number,
            onTap: (focusNode) {
              if (remindedRatio == 0) {
                formKey.currentState!.validate();
              }
            },
            validator: (value) {
              if ((value == null || value.isEmpty) && remindedRatio > 0) {
                return '*Required';
              }
              if (remindedRatio == 0) {
                return '*There is no ratio left to assign';
              }
              if ((double.tryParse(value ?? '0') ?? 0) > remindedRatio) {
                return '*You can not set ratio more than ${remindedRatio.round()}';
              }
              return null;
            },
          ),
        ),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final ratio = TeamMembersEditForm(
          id: ratioID,
          memberID: memberID,
          ratio: double.parse(ratioController.text),
          teamID: widget.team.id,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
