import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_task_manager/features/auth/bloc/auth_bloc.dart';

import '../../auth/bloc/auth_event.dart';
import '../controllers/theme-controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          children: [
            Obx(() {
              final isDark = themeController.themeMode.value == ThemeMode.dark;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Dark Mode', style: TextStyle(fontSize: 18.sp)),
                  Switch(
                    value: isDark,
                    onChanged: (_) => themeController.switchTheme(),
                  ),
                ],
              );
            }),
             SizedBox(height: 24.h),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(LoggedOut());
                Get.offAllNamed('/'); // back to login
              },
            )
          ],
        ),
      ),
    );
  }
}
