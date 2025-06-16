import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_task_manager/widgets/custom_button.dart';

import '../../../widgets/task_tile.dart';
import '../controllers/task_controller.dart';
import '../../../data/models/task_models.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tasks'),
        actions: [
          Obx(() => Icon(
            controller.isOnline.value ? Icons.wifi : Icons.wifi_off,
            color: controller.isOnline.value ? Colors.green : Colors.red,
          )),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchTasksFromFirestore,
          ),
        ],
      ),
      body: Obx(() {
        final tasks = controller.tasks;

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No tasks yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                const Text('Tap + to add your first task'),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.fetchTasksFromFirestore(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final TaskModel task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => controller.deleteTask(task.id),
                child: TaskTile(
                  task: task,
                  onChanged: () => controller.toggleTaskStatus(task.id, task.isDone),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, TaskController controller) {
    final TextEditingController titleController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Task',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Task title'),
          ),
          const SizedBox(height: 10),
          CustomButton(
            onTap: () {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                controller.addTask(title);
                Get.back();
              }
            },
            text: 'add',
          ),
        ],
      ),
    );
  }
}
