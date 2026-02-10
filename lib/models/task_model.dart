import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

class Task {
  final String id;
  String title;
  String description;
  bool isCompleted;
  TaskPriority priority;
  DateTime createdAt;
  DateTime? dueDate;
  Color color;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.priority = TaskPriority.medium,
    required this.createdAt,
    this.dueDate,
    Color? color,
  }) : color = color ?? getColorByPriority(priority);

  static Color getColorByPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return const Color(0xFFFF6584);
      case TaskPriority.medium:
        return const Color(0xFFFFBE0B);
      case TaskPriority.low:
        return const Color(0xFF4ECDC4);
    }
  }

  // Convert Task to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority.index,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'color': color.value,
    };
  }

  // Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      priority: TaskPriority.values[map['priority'] ?? 1],
      createdAt: DateTime.parse(map['createdAt']),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      color: Color(map['color']),
    );
  }

  // Copy with method for updates
  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    TaskPriority? priority,
    DateTime? dueDate,
    Color? color,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      color: color ?? this.color,
    );
  }

  String getPriorityText() {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  IconData getPriorityIcon() {
    switch (priority) {
      case TaskPriority.high:
        return Icons.priority_high_rounded;
      case TaskPriority.medium:
        return Icons.remove_rounded;
      case TaskPriority.low:
        return Icons.arrow_downward_rounded;
    }
  }
}
