import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class AddRatioDialogBox extends StatefulWidget {
  final ResponseTeam team;
  final List<ResponseMember> members;
  final Map<int, double> addedMembers;
  final Function(TeamMemberParams teamMember) onPressedSubmit;
  const AddRatioDialogBox({
    super.key,
    required this.addedMembers,
    required this.team,
    required this.members,
    required this.onPressedSubmit,
  });

  @override
  State<AddRatioDialogBox> createState() => _AddRatioDialogBoxState();
}

class _AddRatioDialogBoxState extends State<AddRatioDialogBox> {
  final TextEditingController ratioController = TextEditingController();
  final TextEditingController teamController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formDropDownKey = GlobalKey<FormState>();
  final List<ResponseMember> notAddedMembers = [];
  double remindedRatio = 100;
  int? memberID;
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
      title: 'Add New Team\'s Member',
      children: [
        AppTextField(label: 'Team', controller: teamController, readOnly: true),
        Gap(20),
        if (notAddedMembers.isNotEmpty)
          AppDropDownButton<ResponseMember>(
            label: 'Members',
            hint: 'Select a member',
            showWarning: isNotSelected,
            value: notAddedMembers.firstWhereOrNull(
              (element) => element.id == memberID,
            ),
            onChanged: (value) {
              memberID = value?.id;
              setState(() {});
            },
            items: notAddedMembers.map((e) {
              return DropdownMenuItem<ResponseMember>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),
          )
        else
          Form(
            key: formDropDownKey,
            child: AppTextField(
              label: 'Members',
              hint: 'Select a member',
              readOnly: true,
              onTap: (focusNode) {
                formDropDownKey.currentState!.validate();
              },
              suffixIcon: Icons.arrow_drop_down_circle_rounded,
              validator: (value) {
                return '*There is no member to add!';
              },
            ),
          ),
        Gap(20),
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
              if ((value ?? '0').parseToDouble > remindedRatio) {
                return '*You can not set ratio more than ${remindedRatio.round()}';
              }
              return null;
            },
          ),
        ),
        Gap(20),
      ],
      onPressed: () {
        if (formDropDownKey.currentState?.validate() == false &&
            notAddedMembers.isEmpty) {
          return;
        }
        if (!formKey.currentState!.validate()) return;
        if (memberID == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        final ratio = TeamMemberParams(
          id: null,
          memberID: memberID!,
          ratio: ratioController.text.parseToDouble,
          teamID: widget.team.id,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
