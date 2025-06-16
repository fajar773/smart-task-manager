import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_task_manager/features/dashboard/screens/dashboard_page.dart';
import 'package:smart_task_manager/features/task/controllers/task_controller.dart';
import 'package:smart_task_manager/services/theme_service.dart';
import 'core/constants/themes.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_event.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/settings/controllers/theme-controller.dart';
import 'data/models/task_models.dart';
import 'features/task/screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  final secureStorage = const FlutterSecureStorage();
  String? key = await secureStorage.read(key: 'hive_key');
  if (key == null) {
    final generatedKey = Hive.generateSecureKey();
    await secureStorage.write(
        key: 'hive_key', value: base64UrlEncode(generatedKey));
    key = base64UrlEncode(generatedKey);
  }

  final encryptionKey = base64Url.decode(key);

  await Hive.openBox<TaskModel>('tasks',
      encryptionCipher: HiveAesCipher(encryptionKey));
  await Hive.openBox('syncQueue');

  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(TaskController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, __) => BlocProvider(
        create: (_) => AuthBloc()..add(AppStarted()),
        child: Obx(() => GetMaterialApp(
          title: 'Smart Task Manager',
          debugShowCheckedModeBanner: false,
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: themeController.themeMode.value,
          initialRoute: '/',
          routes: {
            '/': (_) =>  LoginScreen(),
            '/dashboard': (_) => const DashboardPage(),
          },
        )),
      ),
    );
  }
}
