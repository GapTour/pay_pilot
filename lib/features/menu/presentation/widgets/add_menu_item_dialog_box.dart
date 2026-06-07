import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';

class AddMenuItemDialogBox extends StatefulWidget {
  final Function(MenuParams item) onPressedSubmit;
  const AddMenuItemDialogBox({super.key, required this.onPressedSubmit});

  @override
  State<AddMenuItemDialogBox> createState() => _AddMenuItemDialogBoxState();
}

class _AddMenuItemDialogBoxState extends State<AddMenuItemDialogBox> {
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: S.current.menu_addItem,
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: S.current.textField_label_title,
            hint: S.current.textField_hint_chocolateCake,
            autoFocus: true,
            controller: titleController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.current.validator_required;
              }
              return null;
            },
          ),
        ),
      ],
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        final menuItem = MenuParams(
          id: null,
          title: titleController.text,
          isActive: true,
        );
        widget.onPressedSubmit(menuItem);
        context.pop();
      },
    );
  }
}
