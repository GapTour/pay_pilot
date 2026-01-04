import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_ratio.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class EditEventRatioDialogBox extends StatefulWidget {
  final ResponseEventRatio memberRatio;
  final int eventID;
  final List<ResponseMember> members;
  final Map<int, double> addedMembers;
  final Function(EventRatioParams ratioEvent) onPressedSubmit;
  const EditEventRatioDialogBox({
    super.key,
    required this.memberRatio,
    required this.eventID,
    required this.onPressedSubmit,
    required this.addedMembers,
    required this.members,
  });

  @override
  State<EditEventRatioDialogBox> createState() =>
      _EditEventRatioDialogBoxState();
}

class _EditEventRatioDialogBoxState extends State<EditEventRatioDialogBox> {
  final TextEditingController ratioController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formDropDownKey = GlobalKey<FormState>();
  final List<ResponseMember> notAddedMembers = [];
  double remindedRatio = 100;
  late ResponseMember member;
  late int ratioID;
  bool isNotSelected = false;

  @override
  void dispose() {
    ratioController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    ratioID = widget.memberRatio.id;
    member = widget.members.firstWhere(
      (element) => element.id == widget.memberRatio.memberID,
    );
    ratioController.text = widget.memberRatio.ratio.toString();

    notAddedMembers.add(member);
    remindedRatio = remindedRatio + widget.memberRatio.ratio;

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
      title: 'Edit Ratio',
      children: [
        AppDropDownButton<ResponseMember>(
          label: 'Members',
          hint: 'Select a member',
          showWarning: isNotSelected,
          value: widget.members.firstWhereOrNull(
            (element) => element.id == member.id,
          ),
          onChanged: (value) {
            if (value != null) {
              member = value;
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
        final ratio = EventRatioParams(
          id: ratioID,
          memberID: member.id,
          ratioValue: ratioController.text.parseToDouble,
          eventID: widget.eventID,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
