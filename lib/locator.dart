import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/database/platform/platfrom.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/auth/data/login_api_provider.dart';
import 'package:pay_pilot/features/auth/repository/auth_repository.dart';
import 'package:pay_pilot/features/event_details/data/event_details_db_provider.dart';
import 'package:pay_pilot/features/event_details/repository/event_details_repository.dart';
import 'package:pay_pilot/features/events/data/event_api_provider.dart';
import 'package:pay_pilot/features/events/data/event_db_provider.dart';
import 'package:pay_pilot/features/events/repository/event_repository.dart';
import 'package:pay_pilot/features/guest_details/data/guest_details_api_provider.dart';
import 'package:pay_pilot/features/guest_details/repository/guest_details_repository.dart';
import 'package:pay_pilot/features/guests/data/guest_api_provider.dart';
import 'package:pay_pilot/features/guests/repository/guest_repository.dart';
import 'package:pay_pilot/features/member_details/data/member_details_api_provider.dart';
import 'package:pay_pilot/features/member_details/data/member_details_db_provider.dart';
import 'package:pay_pilot/features/member_details/repository/member_details_repository.dart';
import 'package:pay_pilot/features/members/data/member_api_provider.dart';
import 'package:pay_pilot/features/members/data/member_db_provider.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';
import 'package:pay_pilot/features/menu/data/menu_api_provider.dart';
import 'package:pay_pilot/features/menu/repository/menu_repository.dart';
import 'package:pay_pilot/features/report_details/data/report_details_db_provider.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';
import 'package:pay_pilot/features/reports/data/report_db_provider.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';
import 'package:pay_pilot/features/team_members/data/team_member_api_provider.dart';
import 'package:pay_pilot/features/team_members/data/team_members_db_provider.dart';
import 'package:pay_pilot/features/team_members/repository/team_members_repository.dart';
import 'package:pay_pilot/features/teams/data/teams_api_provider.dart';
import 'package:pay_pilot/features/teams/data/teams_db_provider.dart';
import 'package:pay_pilot/features/teams/repository/team_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  await _callServices();
  _callProviders();
  _callRepositories();
  _callBlocs();
}

Future<void> _callServices() async {
  await dotenv.load(fileName: 'variables.env');

  /// shared preferences
  final SharedPreferences initSharedPreferences =
      await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(initSharedPreferences),
  );

  /// Create secure storage
  const FlutterSecureStorage initSecureStorage = FlutterSecureStorage();
  locator.registerSingleton<SecureStorageService>(
    SecureStorageService(initSecureStorage),
  );

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
  locator.registerLazySingleton<LoginApiProvider>(() => LoginApiProvider());
  locator.registerLazySingleton<MemberApiProvider>(
    () => MemberApiProvider(locator()),
  );
  locator.registerLazySingleton<MemberDbProvider>(
    () => MemberDbProvider(locator()),
  );
  locator.registerLazySingleton<MemberDetailsApiProvider>(
    () => MemberDetailsApiProvider(locator()),
  );
  locator.registerLazySingleton<MemberDetailsDbProvider>(
    () => MemberDetailsDbProvider(locator()),
  );
  locator.registerLazySingleton<GuestApiProvider>(
    () => GuestApiProvider(locator()),
  );
  locator.registerLazySingleton<GuestDetailsApiProvider>(
    () => GuestDetailsApiProvider(locator()),
  );
  locator.registerLazySingleton<EventDbProvider>(
    () => EventDbProvider(locator(), locator()),
  );
  locator.registerLazySingleton<EventApiProvider>(
    () => EventApiProvider(locator()),
  );
  locator.registerLazySingleton<EventDetailsDbProvider>(
    () => EventDetailsDbProvider(locator(), locator()),
  );
  locator.registerLazySingleton<TeamsDbProvider>(
    () => TeamsDbProvider(locator()),
  );
  locator.registerLazySingleton<TeamsApiProvider>(
    () => TeamsApiProvider(locator()),
  );
  locator.registerLazySingleton<TeamMembersDbProvider>(
    () => TeamMembersDbProvider(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<TeamMemberApiProvider>(
    () => TeamMemberApiProvider(locator()),
  );
  locator.registerLazySingleton<MenuApiProvider>(
    () => MenuApiProvider(locator()),
  );
  locator.registerLazySingleton<ReportDbProvider>(
    () => ReportDbProvider(locator(), locator()),
  );
  locator.registerLazySingleton<ReportDetailsDbProvider>(
    () => ReportDetailsDbProvider(locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(locator(), locator()),
  );
  locator.registerLazySingleton<MemberRepository>(
    () => MemberRepository(locator()),
  );
  locator.registerLazySingleton<MemberDetailsRepository>(
    () => MemberDetailsRepository(locator()),
  );
  locator.registerLazySingleton<GuestRepository>(
    () => GuestRepository(locator()),
  );
  locator.registerLazySingleton<GuestDetailsRepository>(
    () => GuestDetailsRepository(locator()),
  );
  locator.registerLazySingleton<EventRepository>(
    () => EventRepository(locator()),
  );
  locator.registerLazySingleton<EventDetailsRepository>(
    () => EventDetailsRepository(locator()),
  );
  locator.registerLazySingleton<TeamRepository>(
    () => TeamRepository(locator()),
  );
  locator.registerLazySingleton<TeamMembersRepository>(
    () => TeamMembersRepository(locator()),
  );
  locator.registerLazySingleton<MenuRepository>(
    () => MenuRepository(locator()),
  );
  locator.registerLazySingleton<ReportRepository>(
    () => ReportRepository(locator()),
  );
  locator.registerLazySingleton<ReportDetailsRepository>(
    () => ReportDetailsRepository(locator()),
  );
}

void _callBlocs() {}
