import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_models.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasks');
  final RxBool isOnline = true.obs;

  late final StreamSubscription<ConnectivityResult> _connectionSub;

  @override
  void onInit() {
    super.onInit();
    _listenToConnectivity();
    loadTasksOffline();
    fetchTasksFromFirestore();
  }

  void _listenToConnectivity() {
    _connectionSub = Connectivity().onConnectivityChanged.listen((result) {
      isOnline.value = result != ConnectivityResult.none;
      if (isOnline.value) {
        _syncOfflineChanges();
      }
    });
  }

  @override
  void onClose() {
    _connectionSub.cancel();
    super.onClose();
  }

  void fetchTasksFromFirestore() {
    _firestore.collection('tasks').snapshots().listen((snapshot) {
      final newTasks = snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data(), doc.id);
      }).toList();
      tasks.value = newTasks;
      saveTasksOffline();
    });
  }

  void loadTasksOffline() {
    tasks.value = _taskBox.values.toList();
  }

  void saveTasksOffline() {
    _taskBox.clear();
    for (var task in tasks) {
      _taskBox.put(task.id, task);
    }
  }

  final Box _syncQueue = Hive.box('syncQueue');

  Future<void> _syncOfflineChanges() async {
    final List<Map> queue = _syncQueue.values.cast<Map>().toList();

    for (var change in queue) {
      final String action = change['action'];
      final String id = change['id'];
      final data = change['data'];

      try {
        if (action == 'add') {
          await _firestore.collection('tasks').doc(id).set(data);
        } else if (action == 'update') {
          await _firestore.collection('tasks').doc(id).update(data);
        } else if (action == 'delete') {
          await _firestore.collection('tasks').doc(id).delete();
        }
      } catch (_) {
        // failed, keep in queue
        continue;
      }

      _syncQueue.delete(change['key']);
    }
  }

  Future<void> _enqueueChange(String action, String id, Map data) async {
    final key = '${DateTime.now().millisecondsSinceEpoch}_$id';
    await _syncQueue.put(key, {
      'key': key,
      'action': action,
      'id': id,
      'data': data,
    });
  }

  Future<void> addTask(String title) async {
    final newId = _firestore.collection('tasks').doc().id;
    final taskData = {'title': title, 'isDone': false};

    if (isOnline.value) {
      await _firestore.collection('tasks').doc(newId).set(taskData);
    } else {
      await _enqueueChange('add', newId, taskData);
      final task = TaskModel(id: newId, title: title, isDone: false);
      tasks.add(task);
      saveTasksOffline();
    }
  }

  Future<void> toggleTaskStatus(String id, bool currentStatus) async {
    final updateData = {'isDone': !currentStatus};

    if (isOnline.value) {
      await _firestore.collection('tasks').doc(id).update(updateData);
    } else {
      await _enqueueChange('update', id, updateData);
      final index = tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        final updated = tasks[index];
        tasks[index] = TaskModel(id: updated.id, title: updated.title, isDone: !updated.isDone);
        saveTasksOffline();
      }
    }
  }

  Future<void> deleteTask(String id) async {
    if (isOnline.value) {
      await _firestore.collection('tasks').doc(id).delete();
    } else {
      await _enqueueChange('delete', id, {});
      tasks.removeWhere((task) => task.id == id);
      saveTasksOffline();
    }
  }
}
