import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_project/core/bloc_observer.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/core/routing/app_router.dart';
import 'package:test_project/core/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_project/features/settings/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupGetIt();

  await EasyLocalization.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<InternetConnectionCubit>()..checkConnectivity(),
        ),
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
      ],
      child: EasyLocalization(
        saveLocale: true,
        useFallbackTranslations: true,
        fallbackLocale: const Locale('en', 'GB'),
        supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'GB')],
        path: 'assets/languages',
        child: MyApp(appRouter: AppRouter()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final settingsCubit = context.read<SettingsCubit>();
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          themeMode: settingsCubit.themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
          ),
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.signupPage,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
