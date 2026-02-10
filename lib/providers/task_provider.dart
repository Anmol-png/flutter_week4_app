import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  // Getters
  List<Task> get tasks => [..._tasks];

  List<Task> get activeTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  int get totalTasks => _tasks.length;

  int get activeTasksCount => activeTasks.length;

  int get completedTasksCount => completedTasks.length;

  double get completionRate =>
      totalTasks == 0 ? 0 : (completedTasksCount / totalTasks) * 100;

  // Get tasks by priority
  List<Task> getTasksByPriority(TaskPriority priority) {
    return _tasks
        .where((task) => task.priority == priority && !task.isCompleted)
        .toList();
  }

  // Get task by ID
  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add new task
  void addTask(Task task) {
    _tasks.insert(0, task); // Add to beginning
    notifyListeners();
  }

  // Update task
  void updateTask(String id, Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Toggle task completion
  void toggleTaskCompletion(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  // Delete task
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Delete all completed tasks
  void deleteCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }

  // Update task priority
  void updateTaskPriority(String id, TaskPriority priority) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].priority = priority;
      _tasks[index].color = Task.getColorByPriority(priority);
      notifyListeners();
    }
  }

  // Sort tasks
  void sortTasksByPriority() {
    _tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return b.priority.index.compareTo(a.priority.index);
    });
    notifyListeners();
  }

  void sortTasksByDate() {
    _tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      return b.createdAt.compareTo(a.createdAt);
    });
    notifyListeners();
  }

  // Search tasks
  List<Task> searchTasks(String query) {
    if (query.isEmpty) return tasks;

    return _tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
          task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Load sample tasks for demo
  void loadSampleTasks() {
    final sampleTasks = [
      Task(
        id: '1',
        title: 'Complete Week 6 Tasks',
        description: 'Implement Provider state management',
        priority: TaskPriority.high,
        createdAt: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: '2',
        title: 'Study Flutter Provider',
        description: 'Learn ChangeNotifier and Consumer widgets',
        priority: TaskPriority.medium,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Task(
        id: '3',
        title: 'Design Task UI',
        description: 'Create beautiful task management interface',
        priority: TaskPriority.low,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isCompleted: true,
      ),
    ];

    _tasks.addAll(sampleTasks);
    notifyListeners();
  }
}
