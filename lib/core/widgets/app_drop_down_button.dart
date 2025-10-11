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
            Text(label!, style: Theme.of(context).textTheme.labelMedium),
            const Gap(6),
          ],
          DecoratedBox(
            decoration: BoxDecoration(
              border: BoxBorder.all(color: kPrimaryContainerColor),
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
              hint: Text(
                hint ?? 'Select a item',
                style: TextStyle(
                  color: kOnPrimaryColor.withAlpha(100),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 14),
              style: Theme.of(context).textTheme.displayLarge,
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
