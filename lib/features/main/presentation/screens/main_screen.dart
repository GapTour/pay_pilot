import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Pilot App')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.membersScreen);
              },
              child: Text('Members'),
            ),
            Gap(12),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.incomesScreen);
              },
              child: Text('Incomes'),
            ),
            Gap(12),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.reportsScreen);
              },
              child: Text('Reports'),
            ),
            Spacer(),
            Text(
              'Version 1.0.1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
