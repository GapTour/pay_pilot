import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppDropDownButton<T> extends StatelessWidget {
  final T? value;
  final Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final String? label;
  final bool? showWarning;
  final String? warningContent;
  final String? hint;
  const AppDropDownButton({
    super.key,
    this.value,
    this.onChanged,
    this.items,
    this.label,
    this.showWarning,
    this.warningContent,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 93,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: TextStyle(
                // color: _hasFocus ? Colors.white : Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(6),
          ],
          DecoratedBox(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: kOnPrimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<T>(
              value: value,
              onChanged: onChanged,
              items: items,
              borderRadius: BorderRadius.circular(8),

              dropdownColor: kSecondaryColor,
              // underline: BoxBorder.all(),
              menuWidth: 320,
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text(hint ?? 'Select a item'),
              padding: EdgeInsets.symmetric(horizontal: 14),
              icon: Icon(
                Icons.arrow_drop_down_circle_rounded,
                color: kSecondaryColor,
              ),
            ),
          ),
          if (showWarning == true) ...[
            Gap(2),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                '*Required',
                style: TextStyle(color: kErrorColor, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
