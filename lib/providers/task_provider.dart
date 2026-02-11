import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  String _filter = 'All';
  String _searchQuery = '';

  List<Task> get tasks {
    return _tasks.where((task) {
      final filterMatch =
          _filter == 'All' ||
          (_filter == 'Completed' && task.isCompleted) ||
          (_filter == 'Pending' && !task.isCompleted);

      final searchMatch = task.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      return filterMatch && searchMatch;
    }).toList();
  }

  int get totalTask => _tasks.length;
  int get completedTask => _tasks.where((e) => e.isCompleted).length;
  int get pendingTask => _tasks.where((e) => !e.isCompleted).length;

  String get filter => _filter;

  void addTask(String title, String description) {
    _tasks.add(
      Task(
        id: DateTime.now().toString(),
        title: title,
        description: description,
      ),
    );
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = _tasks.firstWhere((e) => e.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  void setSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
