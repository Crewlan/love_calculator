// ignore_for_file: library_private_types_in_public_api

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/locale/custom_localization.dart';
import 'core/navigation/router.dart';
import 'core/navigation/routes.dart';
import 'core/utils/app_colors.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  await di.init();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  static _AppState? of(BuildContext context) => context.findAncestorStateOfType<_AppState>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = const Locale('pt', 'BR');
  final _router = AppRouter();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Locale getLocale() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      onGenerateRoute: _router.generateRoutes,
      initialRoute: Routes.home,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.lightest,
      ),
      navigatorObservers: [HeroController()],
      locale: _locale,
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!");

          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
    );
  }
}
