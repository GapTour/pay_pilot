import 'package:flutter/material.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: kSecondaryColor,
      ),
    );
  }
}
