import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/widgets/app_elevated_button.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Pilot App')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: Stack(
          children: [
            GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                AppElevatedButton(
                  child: Center(
                    child: Text(
                      'Members',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  onTap: () {
                    context.pushNamed(AppRoutes.membersScreen);
                  },
                ),
                AppElevatedButton(
                  child: Center(
                    child: Text(
                      'Teams',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  onTap: () {
                    context.pushNamed(AppRoutes.teamsScreen);
                  },
                ),
                AppElevatedButton(
                  child: Center(
                    child: Text(
                      'Events',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  onTap: () {
                    context.pushNamed(AppRoutes.eventsScreen);
                  },
                ),
                AppElevatedButton(
                  child: Center(
                    child: Text(
                      'Reports',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  onTap: () {
                    context.pushNamed(AppRoutes.reportsScreen);
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 15,
              right: 0,
              left: 0,
              child: Text(
                'Version 1.2.0',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
