import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/bloc_observer.dart';
import 'package:test_project/core/di/dependency_injection.dart';
import 'package:test_project/core/cubit/connectivity_cubit/internet_connection_cubit.dart';
import 'package:test_project/features/main_layout/presentation/pages/main_layout_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  runApp(
    BlocProvider(
      create: (context) =>
          getIt<InternetConnectionCubit>()..checkConnectivity(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainLayoutPage(),
    );
  }
}
