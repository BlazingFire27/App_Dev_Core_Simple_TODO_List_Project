import 'package:flutter/material.dart';
import '../model/task.dart';
import '../services/api_service.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _api = ApiService();

  List<Task> _taskList = [];
  bool _loading = false;
  String? _error;

  List<Task> get tasks => _taskList;
  bool get isLoading => _loading;
  String? get errorMessage => _error;

  Future<void> fetchTasks(String userId) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final raw = await _api.getTasks(userId);
      List<Task> parsed = [];
      for (var json in raw) {
        parsed.add(Task.fromJson(json));
      }
      _taskList = parsed;
      notifyListeners();
    }
    catch (error) {
      _error = 'Failed to load tasks: $error';
      notifyListeners();
    }
    finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createTask({
    required String userId,
    required String title,
    required String description,
    required String status,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _api.createTask(userId, title, description, status);

      if (res['message'] == 'Task created successfully' && res['task'] != null) {
        await fetchTasks(userId);
        return true;
      } else {
        _error = res['message'] ?? 'Failed to add task';
        notifyListeners();
        return false;
      }
    }
    catch (error) {
      _error = 'Failed to add task: $error';
      notifyListeners();
      return false;
    }
    finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTask({
    required String taskId,
    required String userId,
    String? title,
    String? description,
    String? status,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _api.updateTask(
        taskId: taskId,
        userId: userId,
        title: title,
        description: description,
        status: status,
      );

      if (res['message'] == 'Task updated successfully') {
        await fetchTasks(userId);
        return true;
      } else {
        _error = res['message'] ?? 'Failed to update task';
        notifyListeners();
        return false;
      }
    }
    catch (error) {
      _error = 'Failed to update task: $error';
      notifyListeners();
      return false;
    }
    finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clearTasks() {
    _taskList = [];
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
