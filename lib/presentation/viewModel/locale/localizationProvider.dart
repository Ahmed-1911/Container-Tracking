import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:container_tracking/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/singleton/settings_session.dart';

final localProvider =
    ChangeNotifierProvider<LocalProvider>((ref) => LocalProvider());

class LocalProvider extends ChangeNotifier {
  Locale _appLocale = const Locale('ar');

  Locale get appLocal => _appLocale;

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constants.languageCode) == null) {
      _appLocale = const Locale('ar');
      notifyListeners();
      return Null;
    }
    _appLocale = Locale(prefs.getString(Constants.languageCode) ?? 'ar');
    notifyListeners();
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
      await prefs.setString(Constants.languageCode, 'ar');
      await prefs.setString(Constants.countryCode, '');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString(Constants.languageCode, 'en');
      await prefs.setString(Constants.countryCode, 'US');
    }
    SettingsSession.instance().loadLanguage();
    notifyListeners();
  }
}
