import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class CustomLocalization {
  final String defaultLocale = 'pt';

  final Locale locale;
  Map<String, String>? sentences;

  CustomLocalization(this.locale);

  static CustomLocalization of(BuildContext context) {
    return Localizations.of<CustomLocalization>(context, CustomLocalization)!;
  }

  String translate(String key) {
    return sentences![key] ?? key;
  }

  Future<CustomLocalization> load() async {
    String data;
    try {
      data = await rootBundle.loadString('./assets/langs/${locale.languageCode}.json');
    } catch (e) {
      debugPrint(
        "*assets for ${locale.languageCode} locale is not found loading default language",
      );
      data = await rootBundle.loadString('./assets/langs/$defaultLocale.json');
    }

    Map<String, dynamic> result = json.decode(data);
    sentences = {};
    result.forEach((String key, dynamic value) {
      sentences![key] = value.toString();
    });

    return CustomLocalization(locale);
  }
}

class LocalizationDelegate extends LocalizationsDelegate<CustomLocalization> {
  final List<String> supportedLanguages = const <String>[
    'en',
    'pt',
  ];

  @override
  bool isSupported(Locale locale) => supportedLanguages.contains(locale.languageCode);

  @override
  Future<CustomLocalization> load(Locale locale) async {
    CustomLocalization localizations = CustomLocalization(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}
