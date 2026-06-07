import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/team_member_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';
import 'package:pay_pilot/features/team_members/data/models/response_team_member.dart';
import 'package:pay_pilot/features/teams/data/models/response_team.dart';

class EditRatioDialogBox extends StatefulWidget {
  final ResponseTeamMember teamMember;
  final ResponseTeam team;
  final List<ResponseMember> members;
  final Map<int, double> addedMembers;
  final Function(TeamMemberParams teamMember) onPressedSubmit;
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
  final List<ResponseMember> notAddedMembers = [];
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
    memberID = widget.teamMember.memberInfo.id;
    ratioController.text = widget.teamMember.ratio.toString();

    notAddedMembers.add(widget.teamMember.memberInfo);
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
      title: S.current.teamDetails_editMembers,
      children: [
        AppTextField(
          label: S.current.textField_label_team,
          controller: teamController,
          readOnly: true,
        ),
        Gap(20),
        AppDropDownButton<ResponseMember>(
          label: S.current.dropDownButton_label_members,
          hint: S.current.dropDownButton_hint_selectMember,
          showWarning: isNotSelected,
          value: notAddedMembers.firstWhereOrNull(
            (element) => element.id == memberID,
          ),
          onChanged: (value) {
            if (value != null) {
              memberID = value.id;
              setState(() {});
            }
          },
          items: notAddedMembers.map((e) {
            return DropdownMenuItem<ResponseMember>(
              value: e,
              child: Text(e.name),
            );
          }).toList(),
        ),
        Gap(20),
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_ratio,
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
                return S.current.validator_required;
              }
              if (remindedRatio == 0) {
                return S.current.validator_thereIsNoRatio;
              }
              if ((double.tryParse(value ?? '0') ?? 0) > remindedRatio) {
                return S.current.validator_ratioCanNotMoreThan(
                  remindedRatio.round(),
                );
              }
              return null;
            },
          ),
        ),
        Gap(20),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final ratio = TeamMemberParams(
          id: ratioID,
          memberID: memberID,
          ratio: ratioController.text.parseToDouble,
          teamID: widget.team.id,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
