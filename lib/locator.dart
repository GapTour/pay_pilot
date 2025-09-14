import 'package:get_it/get_it.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/database/platform/platfrom.dart';
import 'package:pay_pilot/features/event_transactions/data/transaction_db_provider.dart';
import 'package:pay_pilot/features/event_transactions/repository/transaction_repository.dart';
import 'package:pay_pilot/features/events/data/event_db_provider.dart';
import 'package:pay_pilot/features/events/repository/event_repository.dart';
import 'package:pay_pilot/features/member_details/data/member_details_db_provider.dart';
import 'package:pay_pilot/features/member_details/repository/member_details_repository.dart';
import 'package:pay_pilot/features/members/data/member_db_provider.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';
import 'package:pay_pilot/features/report_details/data/report_details_db_provider.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';
import 'package:pay_pilot/features/reports/data/report_db_provider.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';
import 'package:pay_pilot/features/team_members/data/team_members_db_provider.dart';
import 'package:pay_pilot/features/team_members/repository/team_members_repository.dart';
import 'package:pay_pilot/features/teams/data/teams_db_provider.dart';
import 'package:pay_pilot/features/teams/repository/team_repository.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  _callServices();
  _callProviders();
  _callRepositories();
  _callBlocs();
}

void _callServices() {
  locator.registerLazySingleton(
    () => AppDatabase(Platform.createDatabaseConnection('pay-pilot-db')),
  );

  locator.registerSingleton<TeamDao>(TeamDao(locator()));
  locator.registerSingleton<ReportDao>(ReportDao(locator()));
  locator.registerSingleton<RatioDao>(RatioDao(locator()));
  locator.registerSingleton<MemberDao>(MemberDao(locator()));
  locator.registerSingleton<EventDao>(EventDao(locator()));
}

void _callProviders() {
  locator.registerLazySingleton<MemberDbProvider>(
    () => MemberDbProvider(locator()),
  );
  locator.registerLazySingleton<MemberDetailsDbProvider>(
    () => MemberDetailsDbProvider(locator()),
  );
  locator.registerLazySingleton<EventDbProvider>(
    () => EventDbProvider(locator(), locator()),
  );
  locator.registerLazySingleton<TransactionDbProvider>(
    () => TransactionDbProvider(locator()),
  );
  locator.registerLazySingleton<TeamsDbProvider>(
    () => TeamsDbProvider(locator()),
  );
  locator.registerLazySingleton<TeamMembersDbProvider>(
    () => TeamMembersDbProvider(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<ReportDbProvider>(
    () => ReportDbProvider(locator(), locator()),
  );
  locator.registerLazySingleton<ReportDetailsDbProvider>(
    () => ReportDetailsDbProvider(locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<MemberRepository>(
    () => MemberRepository(locator()),
  );
  locator.registerLazySingleton<MemberDetailsRepository>(
    () => MemberDetailsRepository(locator()),
  );
  locator.registerLazySingleton<EventRepository>(
    () => EventRepository(locator()),
  );
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepository(locator()),
  );
  locator.registerLazySingleton<TeamRepository>(
    () => TeamRepository(locator()),
  );
  locator.registerLazySingleton<TeamMembersRepository>(
    () => TeamMembersRepository(locator()),
  );
  locator.registerLazySingleton<ReportRepository>(
    () => ReportRepository(locator()),
  );
  locator.registerLazySingleton<ReportDetailsRepository>(
    () => ReportDetailsRepository(locator()),
  );
}

void _callBlocs() {}
