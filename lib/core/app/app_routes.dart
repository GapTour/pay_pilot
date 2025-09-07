import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/features/incomes/presentation/cubit/incomes_cubit.dart';
import 'package:pay_pilot/features/incomes/presentation/screens/incomes_screen.dart';
import 'package:pay_pilot/features/main/presentation/screens/main_screen.dart';
import 'package:pay_pilot/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot/features/members/presentation/screens/members_screen.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:pay_pilot/features/reports/presentation/screens/reports_screen.dart';
import 'package:pay_pilot/locator.dart';

class AppRoutes {
  static const String mainScreen = 'mainScreen';
  static const String membersScreen = 'membersScreen';
  static const String reportsScreen = 'reportsScreen';
  static const String incomesScreen = 'incomesScreen';

  static GoRouter router = GoRouter(
    // navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: MainScreen.routeName,
    routes: [
      GoRoute(
        name: mainScreen,
        path: MainScreen.routeName,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: membersScreen,
        path: MembersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MembersCubit(locator()),
          child: const MembersScreen(),
        ),
      ),
      GoRoute(
        name: reportsScreen,
        path: ReportsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => ReportsCubit(locator()),
          child: const ReportsScreen(),
        ),
      ),
      GoRoute(
        name: incomesScreen,
        path: IncomesScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => IncomesCubit(locator()),
          child: const IncomesScreen(),
        ),
      ),
    ],
  );
}
