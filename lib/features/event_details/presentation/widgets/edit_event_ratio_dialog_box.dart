import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/models/member_ratio_model.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/event_details/data/models/event_ratio_edit_form.dart';

class EditEventRatioDialogBox extends StatefulWidget {
  final MemberRatioModel memberRatio;
  final int eventID;
  final List<Member> members;
  final Map<int, double> addedMembers;
  final Function(EventRatioEditForm ratioEvent) onPressedSubmit;
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
  final List<Member> notAddedMembers = [];
  double remindedRatio = 100;
  late Member member;
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
    member = widget.memberRatio.member;
    ratioController.text = widget.memberRatio.ratio.toString();

    notAddedMembers.add(widget.memberRatio.member);
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
        AppDropDownButton<Member>(
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
        final ratio = EventRatioEditForm(
          id: ratioID,
          member: member,
          ratio: ratioController.text.parseToDouble,
          eventID: widget.eventID,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
