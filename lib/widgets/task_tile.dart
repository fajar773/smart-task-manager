import 'package:flutter/material.dart';

import '../data/models/task_models.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onChanged;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => onChanged(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            decoration:
            task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            color: task.isDone ? Colors.grey : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.drag_indicator), // placeholder
      ),
    );
  }
}
