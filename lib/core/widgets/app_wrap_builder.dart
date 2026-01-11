import 'package:flutter/material.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppWrapBuilder extends StatelessWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const AppWrapBuilder(
    this.children, {
    this.backgroundColor,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = List<Widget>.generate(
      children.length,
      (index) => children[index],
    );

    return Wrap(
      spacing: 3.5,
      runSpacing: 3.5,
      children: items.map((e) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? kSecondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
            child: e,
          ),
        );
      }).toList(),
    );
  }
}
