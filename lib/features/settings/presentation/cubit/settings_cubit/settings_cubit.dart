import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/services/shared_pref_services.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static const String _themeKey = 'themeMode';
  static const String _localeKey = 'locale';

  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('en', 'GB');

  Future<void> init() async {
    final savedTheme = SharedPrefService.getString(_themeKey);
    if (savedTheme != null) {
      themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeUpdated(themeMode));
    }

    final savedLocale = SharedPrefService.getString(_localeKey);
    if (savedLocale != null) {
      final parts = savedLocale.split('-');

      locale = parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);

      emit(LocaleUpdated(locale));
    }
  }

  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    await SharedPrefService.setString(
      _themeKey,
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );

    emit(ThemeUpdated(themeMode));
  }

  Future<void> changeLocale(BuildContext context, Locale newLocale) async {
    locale = newLocale;

    await SharedPrefService.setString(_localeKey, newLocale.toLanguageTag());

    await context.setLocale(newLocale);

    emit(LocaleUpdated(locale));
  }

  bool get isDark => themeMode == ThemeMode.dark;

  bool get isArabic => locale.languageCode == 'ar';
}
