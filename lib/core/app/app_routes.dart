import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/utils/constants/app_arguments.dart';
import 'package:pay_pilot/features/event_details/presentation/cubit/event_details_cubit.dart';
import 'package:pay_pilot/features/event_details/presentation/screens/event_details_screen.dart';
import 'package:pay_pilot/features/events/presentation/cubit/events_cubit.dart';
import 'package:pay_pilot/features/events/presentation/screens/events_screen.dart';
import 'package:pay_pilot/features/main/presentation/screens/main_screen.dart';
import 'package:pay_pilot/features/member_details/presentation/cubit/members_details_cubit.dart';
import 'package:pay_pilot/features/member_details/presentation/screens/member_details_screen.dart';
import 'package:pay_pilot/features/members/presentation/cubit/members_cubit.dart';
import 'package:pay_pilot/features/members/presentation/screens/members_screen.dart';
import 'package:pay_pilot/features/report_details/presentation/cubit/report_details_cubit.dart';
import 'package:pay_pilot/features/report_details/presentation/screens/report_details_screen.dart';
import 'package:pay_pilot/features/reports/presentation/cubit/reports_cubit.dart';
import 'package:pay_pilot/features/reports/presentation/screens/reports_screen.dart';
import 'package:pay_pilot/features/team_members/presentation/cubit/ratios_cubit.dart';
import 'package:pay_pilot/features/team_members/presentation/screens/team_members_screen.dart';
import 'package:pay_pilot/features/teams/presentation/cubit/teams_cubit.dart';
import 'package:pay_pilot/features/teams/presentation/screens/teams_screen.dart';
import 'package:pay_pilot/locator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String mainScreen = 'mainScreen';
  static const String membersScreen = 'membersScreen';
  static const String memberDetailsScreen = 'memberDetailsScreen';
  static const String eventsScreen = 'eventsScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
  static const String reportsScreen = 'reportsScreen';
  static const String reportDetailsScreen = 'reportDetailsScreen';
  static const String teamsScreen = 'teamsScreen';
  static const String teamMembersScreen = 'teamMembersScreen';

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
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
        name: memberDetailsScreen,
        path: MemberDetailsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => MembersDetailsCubit(locator()),
          child: MemberDetailsScreen(
            memberID: state.pathParameters[AppArguments.memberDetails]!,
          ),
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
        name: eventsScreen,
        path: EventsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => EventsCubit(locator()),
          child: const EventsScreen(),
        ),
      ),
      GoRoute(
        name: eventDetailsScreen,
        path: EventDetailsScreen.routeName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EventDetailsCubit(locator())),
          ],
          child: EventDetailsScreen(
            eventID: state.pathParameters[AppArguments.eventDetails]!,
          ),
        ),
      ),
      GoRoute(
        name: reportDetailsScreen,
        path: ReportDetailsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => ReportDetailsCubit(locator()),
          child: ReportDetailsScreen(
            reportID: state.pathParameters[AppArguments.reportDetails]!,
          ),
        ),
      ),
      GoRoute(
        name: teamMembersScreen,
        path: TeamMembersScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => RatiosCubit(locator()),
          child: TeamMembersScreen(
            teamID: state.pathParameters[AppArguments.teamDetails]!,
          ),
        ),
      ),
      GoRoute(
        name: teamsScreen,
        path: TeamsScreen.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => TeamsCubit(locator()),
          child: TeamsScreen(),
        ),
      ),
    ],
  );
}
