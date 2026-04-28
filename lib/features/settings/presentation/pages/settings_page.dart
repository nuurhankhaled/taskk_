import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/settings/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:test_project/features/settings/presentation/pages/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.watch<SettingsCubit>();
          print(cubit.locale.languageCode);
          final selectedLang = cubit.locale.languageCode;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsTile(title: 'Appearance'.tr(), isHeader: true),
                const SizedBox(height: 12),
                SettingsTile(
                  title: 'Dark Mode'.tr(),
                  subtitle: cubit.isDark ? 'On'.tr() : 'Off'.tr(),
                  trailing: Switch(value: cubit.isDark, activeColor: Colors.deepPurple, onChanged: (_) => cubit.toggleTheme()),
                ),

                const SizedBox(height: 24),

                SettingsTile(title: 'Language / اللغة', isHeader: true),
                const SizedBox(height: 12),

                SettingsTile(
                  title: 'English',
                  selected: !cubit.isArabic,
                  trailing: Radio<String>(
                    value: 'en',
                    groupValue: cubit.locale.languageCode,
                    activeColor: Colors.deepPurple,
                    onChanged: (_) {
                      cubit.changeLocale(context, const Locale('en', 'GB'));
                    },
                  ),
                ),

                SettingsTile(
                  title: 'العربية',
                  selected: cubit.isArabic,
                  trailing: Radio<String>(
                    value: 'ar',
                    groupValue: cubit.locale.languageCode,
                    activeColor: Colors.deepPurple,
                    onChanged: (_) {
                      cubit.changeLocale(context, const Locale('ar', 'EG'));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
