import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class AppDialogBox extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onPressed;
  const AppDialogBox({
    super.key,
    required this.title,
    required this.children,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 780,
        height: 507,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              ListView(
                children: [
                  Text(title, style: TextStyle(fontSize: 22)),
                  Gap(18),
                  ...children,
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          onTap: onPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Submit', textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                      Gap(8),
                      TextButton(
                        onPressed: () => context.pop(),

                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
