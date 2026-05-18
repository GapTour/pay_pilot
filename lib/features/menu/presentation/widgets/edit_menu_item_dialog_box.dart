// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/menu_params.dart';
import 'package:pay_pilot/core/widgets/app_dialog_box.dart';
import 'package:pay_pilot/core/widgets/app_text_field.dart';
import 'package:pay_pilot/features/menu/data/models/response_menu.dart';

class EditMenuItemDialogBox extends StatefulWidget {
  final ResponseMenu menuItem;
  final Function(MenuParams menuItem) onPressedSubmit;
  const EditMenuItemDialogBox({
    super.key,
    required this.menuItem,
    required this.onPressedSubmit,
  });

  @override
  State<EditMenuItemDialogBox> createState() => _EditMenuItemDialogBoxState();
}

class _EditMenuItemDialogBoxState extends State<EditMenuItemDialogBox> {
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late int itemID;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    itemID = widget.menuItem.id;
    titleController.text = widget.menuItem.title;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogBox(
      title: 'Edit Menu Item',
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
        final menu = MenuParams(
          id: itemID,
          title: titleController.text,
          isActive: true,
        );
        widget.onPressedSubmit(menu);
        context.pop();
      },
    );
  }
}
