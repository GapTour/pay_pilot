import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/event_ratio_params.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/extensions/persian_numbers_converter.dart';
import 'package:pay_pilot/core/utils/helpers/debounce_helper.dart';
import 'package:pay_pilot/core/widgets/app_drop_down_button.dart';
import 'package:pay_pilot/core/widgets/app_modal_column_view_skin.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/members/data/models/response_member.dart';

class AddEventRatioModalView extends StatefulWidget {
  final int eventID;
  final List<ResponseMember> members;
  final Map<int, double> addedMembers;
  final Function(EventRatioParams ratioEvent) onPressedSubmit;
  const AddEventRatioModalView({
    super.key,
    required this.eventID,
    required this.onPressedSubmit,
    required this.addedMembers,
    required this.members,
  });

  @override
  State<AddEventRatioModalView> createState() => _AddEventRatioModalViewState();
}

class _AddEventRatioModalViewState extends State<AddEventRatioModalView> {
  final TextEditingController ratioController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formDropDownKey = GlobalKey<FormState>();
  final List<ResponseMember> notAddedMembers = [];
  double remindedRatio = 100;
  ResponseMember? member;
  bool isNotSelected = false;
  late DebounceHelper debounce;

  @override
  void dispose() {
    ratioController.dispose();
    debounce.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    debounce = DebounceHelper();

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
    return AppModalColumnViewSkin(
      children: [
        AppDropDownButton<ResponseMember>(
          label: S.current.dropDownButton_label_members,
          hint: S.current.dropDownButton_hint_selectMember,
          showWarning: isNotSelected,
          value: widget.members.firstWhereOrNull(
            (element) => element.id == member?.id,
          ),
          onChanged: (value) {
            if (value != null) {
              member = value;
              isNotSelected = false;
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
            onChange: (value) {
              debounce.call(() {
                final isZero =
                    value.replaceAll('-', '').trim() == '0' ||
                    value.replaceAll('-', '').trim() == '0.0';

                if (isZero) ratioController.clear();
              });
            },
          ),
        ),
        Gap(120),
      ],
      onSubmit: () {
        if (!formKey.currentState!.validate()) return;
        if (member == null) {
          isNotSelected = true;
          setState(() {});
          return;
        }
        final ratio = EventRatioParams(
          id: null,
          memberID: member!.id,
          ratioValue: ratioController.text.parseToDouble,
          eventID: widget.eventID,
        );
        widget.onPressedSubmit(ratio);
        context.pop();
      },
    );
  }
}
