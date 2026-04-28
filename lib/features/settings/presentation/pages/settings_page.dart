import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/settings/presentation/cubit/settings_cubit/settings_cubit.dart';

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
                const _SectionTitle(title: 'Appearance'),
                const SizedBox(height: 12),

                _SettingsTile(
                  title: 'Dark Mode',
                  subtitle: cubit.isDark ? 'On' : 'Off',
                  trailing: Switch(
                    value: cubit.isDark,
                    activeColor: Colors.deepPurple,
                    onChanged: (_) => cubit.toggleTheme(),
                  ),
                ),

                const SizedBox(height: 24),

                const _SectionTitle(title: 'Language'),
                const SizedBox(height: 12),

                _SettingsTile(
                  title: 'English',
                  selected: !cubit.isArabic,
                  trailing: Radio<String>(
                    value: 'en',
                    groupValue: cubit.locale.languageCode,
                    activeColor: Colors.deepPurple,
                    onChanged: (_) {
                      print('change to english');
                      cubit.changeLocale(context, const Locale('en', 'GB'));
                      print(cubit.isArabic);
                    },
                  ),
                ),

                _SettingsTile(
                  title: 'العربية',
                  selected: cubit.isArabic,
                  trailing: Radio<String>(
                    value: 'ar',
                    groupValue: cubit.locale.languageCode,
                    activeColor: Colors.deepPurple,
                    onChanged: (_) {
                      print('change to arabic');
                      cubit.changeLocale(context, const Locale('ar', 'EG'));
                      print(cubit.isArabic);
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.selected,
  });
  final bool? selected;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: -2),
        ],
      ),
      child: ListTile(
        selected: selected ?? false,
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
