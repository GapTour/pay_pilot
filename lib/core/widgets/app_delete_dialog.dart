import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppDeleteDialog {
  AppDeleteDialog._();

  static showDefault(BuildContext context, {required VoidCallback onDelete}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          title: Text(
            S.current.alertDialog_areYouSure,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: Text(
            S.current.alertDialog_noticeThisAboutAction,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                S.current.button_title_cancel,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            AppElevatedButton(
              onTap: () {
                onDelete.call();
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: Text(
                  S.current.button_title_delete,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(color: kErrorColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static showCustom(
    BuildContext context, {
    required VoidCallback onPressed,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kPrimaryColor,
          title: Text(
            S.current.alertDialog_areYouSure,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                S.current.button_title_cancel,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            AppElevatedButton(
              onTap: () {
                onPressed.call();
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 5,
                ),
                child: Text(
                  S.current.button_title_submit,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(color: kErrorColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
