import 'package:hive/hive.dart';

part 'task_models.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool isDone;

  TaskModel({required this.id, required this.title, this.isDone = false});

  factory TaskModel.fromMap(Map<String, dynamic> map, String docId) {
    return TaskModel(
      id: docId,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}
