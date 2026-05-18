import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
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
      title: 'Add New Menu',
      children: [
        Form(
          key: formKey,
          child: AppTextField(
            label: 'Title',
            hint: 'Chocolate cake',
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
