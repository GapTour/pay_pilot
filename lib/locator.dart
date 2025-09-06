import 'package:get_it/get_it.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/platform/platfrom.dart';
import 'package:pay_pilot/core/services/db_service.dart';
import 'package:pay_pilot/features/members/data/member_db_provider.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';

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
}

void _callRepositories() {
  locator.registerLazySingleton<MemberRepository>(
    () => MemberRepository(locator()),
  );
}

void _callBlocs() {}
