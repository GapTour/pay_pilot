import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pay_pilot/core/app/app_routes.dart';
import 'package:pay_pilot/core/data/enums/language_code.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/utils/imports/flutter_quill_localization/quill_localizations.dart';
import 'package:pay_pilot/core/utils/theme/app_theme.dart';
import 'package:pay_pilot/features/change_language/presentation/cubit/language_cubit.dart';
import 'package:pay_pilot/locator.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  if (!kIsWeb) {
    if (Platform.isIOS || Platform.isAndroid) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }

    if (Platform.isMacOS || Platform.isWindows) {
      await windowManager.ensureInitialized();

      WindowOptions windowOptions = WindowOptions(
        minimumSize: const Size(600, 850),
        // maximumSize: const Size(800, 600),
        size: Size(600, 850),
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
      });
    }
  }

  /// init locator
  await locatorSetup();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      BlocProvider(
        create: (context) => LanguageCubit(locator())..fetchLanguageInfo(),
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        LanguageCode language = LanguageCode.persian;

        if (state.materialLanguageStatus is MaterialChangingSuccess) {
          language =
              (state.materialLanguageStatus as MaterialChangingSuccess).code;
        }

        return MaterialApp.router(
          routerConfig: AppRoutes.router,
          themeMode: ThemeMode.dark,
          theme: appTheme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            ...quillLocalizationsDelegates,
          ],
          title: 'Pay Pilot',
          locale: Locale(language.code, ''),
          supportedLocales: LanguageCode.values
              .map((e) => Locale(e.code, ''))
              .toList(),
        );
      },
    );
  }
}
