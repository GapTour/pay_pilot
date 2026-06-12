import 'package:flutter/material.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppModalColumnViewSkin extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onSubmit;
  const AppModalColumnViewSkin({
    required this.children,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: children,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(color: kPrimaryColor),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AppElevatedButton(
                onTap: onSubmit,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.current.button_title_submit,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
