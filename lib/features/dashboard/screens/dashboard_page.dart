import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../settings/controllers/theme-controller.dart';
import '../../settings/screens/setting_screen.dart';
import '../../task/controllers/task_controller.dart';
import '../../task/screens/task_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🧠 Smart Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeController.switchTheme(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome back!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Obx(() {
            final totalTasks = taskController.tasks.length;
            final doneTasks = taskController.tasks.where((t) => t.isDone).length;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$doneTasks / $totalTasks tasks completed',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _DashboardCard(
                  title: 'Tasks',
                  icon: Icons.list_alt,
                  color: Colors.blue,
                  onTap: () => Get.to(() => TaskScreen()),
                ),
                _DashboardCard(
                  title: 'Settings',
                  icon: Icons.settings,
                  color: Colors.teal,
                  onTap: () => Get.to(() => const SettingsScreen()),
                ),
                // Add more cards like Profile, Notifications, etc
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 16, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
