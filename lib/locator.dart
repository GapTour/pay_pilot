import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pay_pilot/core/database/app_database.dart';
import 'package:pay_pilot/core/database/daos/event_dao/event_dao.dart';
import 'package:pay_pilot/core/database/daos/guest_dao/guest_dao.dart';
import 'package:pay_pilot/core/database/daos/member_dao/member_dao.dart';
import 'package:pay_pilot/core/database/daos/menu_dao/menu_dao.dart';
import 'package:pay_pilot/core/database/daos/ratio_dao/ratio_dao.dart';
import 'package:pay_pilot/core/database/daos/report_dao/report_dao.dart';
import 'package:pay_pilot/core/database/daos/settings_dao/settings_dao.dart';
import 'package:pay_pilot/core/database/daos/team_dao/team_dao.dart';
import 'package:pay_pilot/core/database/platform/platfrom.dart';
import 'package:pay_pilot/core/utils/services/secure_storage_service.dart';
import 'package:pay_pilot/core/utils/services/shared_preferences_service.dart';
import 'package:pay_pilot/features/auth/data/login_api_provider.dart';
import 'package:pay_pilot/features/auth/repository/auth_repository.dart';
import 'package:pay_pilot/features/change_language/data/language_local_provider.dart';
import 'package:pay_pilot/features/change_language/repository/language_repository.dart';
import 'package:pay_pilot/features/event_details/data/providers/event_details_api_provider.dart';
import 'package:pay_pilot/features/event_details/data/sources/local_event_details_source.dart';
import 'package:pay_pilot/features/event_details/data/sources/remote_event_details_source.dart';
import 'package:pay_pilot/features/event_details/repository/event_details_repository.dart';
import 'package:pay_pilot/features/events/data/providers/event_api_provider.dart';
import 'package:pay_pilot/features/events/data/sources/local_event_source.dart';
import 'package:pay_pilot/features/events/data/sources/remote_event_source.dart';
import 'package:pay_pilot/features/events/repository/event_repository.dart';
import 'package:pay_pilot/features/guest_details/data/providers/guest_details_api_provider.dart';
import 'package:pay_pilot/features/guest_details/data/sources/local_guest_details_source.dart';
import 'package:pay_pilot/features/guest_details/data/sources/remote_guest_details_source.dart';
import 'package:pay_pilot/features/guest_details/repository/guest_details_repository.dart';
import 'package:pay_pilot/features/guests/data/providers/guest_api_provider.dart';
import 'package:pay_pilot/features/guests/data/sources/local_guest_source.dart';
import 'package:pay_pilot/features/guests/data/sources/remote_guest_source.dart';
import 'package:pay_pilot/features/guests/repository/guest_repository.dart';
import 'package:pay_pilot/features/member_details/data/providers/member_details_api_provider.dart';
import 'package:pay_pilot/features/member_details/data/sources/local_member_details_source.dart';
import 'package:pay_pilot/features/member_details/data/sources/remote_member_details_source.dart';
import 'package:pay_pilot/features/member_details/repository/member_details_repository.dart';
import 'package:pay_pilot/features/members/data/providers/member_api_provider.dart';
import 'package:pay_pilot/features/members/data/sources/local_member_source.dart';
import 'package:pay_pilot/features/members/data/sources/remote_member_source.dart';
import 'package:pay_pilot/features/members/repository/member_repository.dart';
import 'package:pay_pilot/features/menu/data/providers/menu_api_provider.dart';
import 'package:pay_pilot/features/menu/data/sources/local_menu_source.dart';
import 'package:pay_pilot/features/menu/data/sources/remote_menu_source.dart';
import 'package:pay_pilot/features/menu/repository/menu_repository.dart';
import 'package:pay_pilot/features/report_details/data/providers/report_details_api_provider.dart';
import 'package:pay_pilot/features/report_details/data/sources/local_report_details_source.dart';
import 'package:pay_pilot/features/report_details/data/sources/remote_report_details_source.dart';
import 'package:pay_pilot/features/report_details/repository/report_details_repository.dart';
import 'package:pay_pilot/features/reports/data/providers/report_api_provider.dart';
import 'package:pay_pilot/features/reports/data/sources/local_report_source.dart';
import 'package:pay_pilot/features/reports/data/sources/remote_report_source.dart';
import 'package:pay_pilot/features/reports/repository/report_repository.dart';
import 'package:pay_pilot/features/settings/data/sources/backup_native_source.dart';
import 'package:pay_pilot/features/settings/repository/backup_provider_repository.dart';
import 'package:pay_pilot/features/team_members/data/providers/team_member_api_provider.dart';
import 'package:pay_pilot/features/team_members/data/sources/local_team_members_source.dart';
import 'package:pay_pilot/features/team_members/data/sources/remote_team_members_source.dart';
import 'package:pay_pilot/features/team_members/repository/team_members_repository.dart';
import 'package:pay_pilot/features/teams/data/providers/teams_api_provider.dart';
import 'package:pay_pilot/features/teams/data/sources/local_team_source.dart';
import 'package:pay_pilot/features/teams/data/sources/remote_team_source.dart';
import 'package:pay_pilot/features/teams/repository/team_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> locatorSetup() async {
  await _callServices();
  _callProviders();
  _callSources();
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
  locator.registerSingleton<GuestDao>(GuestDao(locator()));
  locator.registerSingleton<MenuDao>(MenuDao(locator()));
  locator.registerSingleton<SettingsDao>(SettingsDao(locator()));
}

void _callProviders() {
  locator.registerLazySingleton<LanguageLocalProvider>(
    () => LanguageLocalProvider(locator()),
  );

  locator.registerLazySingleton<LoginApiProvider>(() => LoginApiProvider());

  locator.registerLazySingleton<MemberApiProvider>(
    () => MemberApiProvider(locator()),
  );
  locator.registerLazySingleton<MemberDetailsApiProvider>(
    () => MemberDetailsApiProvider(locator()),
  );

  locator.registerLazySingleton<GuestApiProvider>(
    () => GuestApiProvider(locator()),
  );
  locator.registerLazySingleton<GuestDetailsApiProvider>(
    () => GuestDetailsApiProvider(locator()),
  );

  locator.registerLazySingleton<EventApiProvider>(
    () => EventApiProvider(locator()),
  );
  locator.registerLazySingleton<EventDetailsApiProvider>(
    () => EventDetailsApiProvider(locator()),
  );

  locator.registerLazySingleton<TeamsApiProvider>(
    () => TeamsApiProvider(locator()),
  );
  locator.registerLazySingleton<TeamMemberApiProvider>(
    () => TeamMemberApiProvider(locator()),
  );

  locator.registerLazySingleton<MenuApiProvider>(
    () => MenuApiProvider(locator()),
  );

  locator.registerLazySingleton<ReportApiProvider>(
    () => ReportApiProvider(locator()),
  );
  locator.registerLazySingleton<ReportDetailsApiProvider>(
    () => ReportDetailsApiProvider(locator()),
  );
}

void _callSources() {
  locator.registerLazySingleton<LocalMemberSource>(
    () => LocalMemberSource(locator()),
  );
  locator.registerLazySingleton<RemoteMemberSource>(
    () => RemoteMemberSource(locator()),
  );
  locator.registerLazySingleton<LocalMemberDetailsSource>(
    () => LocalMemberDetailsSource(locator()),
  );
  locator.registerLazySingleton<RemoteMemberDetailsSource>(
    () => RemoteMemberDetailsSource(locator()),
  );

  locator.registerLazySingleton<RemoteGuestSource>(
    () => RemoteGuestSource(locator()),
  );
  locator.registerLazySingleton<LocalGuestSource>(
    () => LocalGuestSource(locator()),
  );
  locator.registerLazySingleton<RemoteGuestDetailsSource>(
    () => RemoteGuestDetailsSource(locator()),
  );
  locator.registerLazySingleton<LocalGuestDetailsSource>(
    () => LocalGuestDetailsSource(locator()),
  );

  locator.registerLazySingleton<RemoteTeamSource>(
    () => RemoteTeamSource(locator()),
  );
  locator.registerLazySingleton<LocalTeamSource>(
    () => LocalTeamSource(locator()),
  );
  locator.registerLazySingleton<RemoteTeamMembersSource>(
    () => RemoteTeamMembersSource(locator()),
  );
  locator.registerLazySingleton<LocalTeamMembersSource>(
    () => LocalTeamMembersSource(locator(), locator()),
  );

  locator.registerLazySingleton<RemoteMenuSource>(
    () => RemoteMenuSource(locator()),
  );
  locator.registerLazySingleton<LocalMenuSource>(
    () => LocalMenuSource(locator()),
  );

  locator.registerLazySingleton<RemoteEventSource>(
    () => RemoteEventSource(locator()),
  );
  locator.registerLazySingleton<LocalEventSource>(
    () => LocalEventSource(locator(), locator()),
  );
  locator.registerLazySingleton<RemoteEventDetailsSource>(
    () => RemoteEventDetailsSource(locator()),
  );
  locator.registerLazySingleton<LocalEventDetailsSource>(
    () => LocalEventDetailsSource(locator(), locator(), locator(), locator()),
  );

  locator.registerLazySingleton<RemoteReportSource>(
    () => RemoteReportSource(locator()),
  );
  locator.registerLazySingleton<LocalReportSource>(
    () => LocalReportSource(locator(), locator()),
  );
  locator.registerLazySingleton<RemoteReportDetailsSource>(
    () => RemoteReportDetailsSource(locator()),
  );
  locator.registerLazySingleton<LocalReportDetailsSource>(
    () => LocalReportDetailsSource(locator(), locator()),
  );

  locator.registerLazySingleton<BackupNativeSource>(
    () => BackupNativeSource(locator()),
  );
}

void _callRepositories() {
  locator.registerLazySingleton<LanguageRepository>(
    () => LanguageRepository(locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<MemberRepository>(
    () => MemberRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<MemberDetailsRepository>(
    () => MemberDetailsRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<GuestRepository>(
    () => GuestRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<GuestDetailsRepository>(
    () => GuestDetailsRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<EventRepository>(
    () => EventRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<EventDetailsRepository>(
    () => EventDetailsRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<TeamRepository>(
    () => TeamRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<TeamMembersRepository>(
    () => TeamMembersRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<MenuRepository>(
    () => MenuRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<ReportRepository>(
    () => ReportRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<ReportDetailsRepository>(
    () => ReportDetailsRepository(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<BackupProviderRepository>(
    () => BackupProviderRepository(locator()),
  );
}

void _callBlocs() {}
