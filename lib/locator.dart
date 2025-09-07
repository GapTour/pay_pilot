import 'package:get_it/get_it.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/platform/platfrom.dart';
import 'package:pay_pilot/core/services/db_service.dart';
import 'package:pay_pilot/features/incomes/data/income_db_provider.dart';
import 'package:pay_pilot/features/incomes/repository/income_repository.dart';
import 'package:pay_pilot/features/members/data/member_db_provider.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';
import 'package:pay_pilot/features/report_details/data/report_details_db_provider.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';
import 'package:pay_pilot/features/reports/data/report_db_provider.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  _callServices();
  _callProviders();
  _callRepositories();
  _callBlocs();
}

void _callServices() {
  final database = locator.registerSingleton<AppDatabase>(
    AppDatabase(Platform.createDatabaseConnection('pay_pilot_db')),
  );

  locator.registerSingleton<DatabaseService>(DatabaseService(database));
}

void _callProviders() {
  locator.registerLazySingleton<MemberDbProvider>(
    () => MemberDbProvider(locator()),
  );
  locator.registerLazySingleton<IncomeDbProvider>(
    () => IncomeDbProvider(locator()),
  );
  locator.registerLazySingleton<ReportDbProvider>(
    () => ReportDbProvider(locator()),
  );
  locator.registerLazySingleton<ReportDetailsDbProvider>(
    () => ReportDetailsDbProvider(locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<MemberRepository>(
    () => MemberRepository(locator()),
  );
  locator.registerLazySingleton<IncomeRepository>(
    () => IncomeRepository(locator()),
  );
  locator.registerLazySingleton<ReportRepository>(
    () => ReportRepository(locator()),
  );
  locator.registerLazySingleton<ReportDetailsRepository>(
    () => ReportDetailsRepository(locator()),
  );
}

void _callBlocs() {}
