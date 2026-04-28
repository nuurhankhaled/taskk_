part of 'settings_cubit.dart';

sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {}

class ThemeUpdated extends SettingsState {
  final ThemeMode themeMode;
  const ThemeUpdated(this.themeMode);
}

class LocaleUpdated extends SettingsState {
  final Locale locale;
  const LocaleUpdated(this.locale);
}
