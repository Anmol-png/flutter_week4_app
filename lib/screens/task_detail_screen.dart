import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final task = taskProvider.getTaskById(taskId);

        if (task == null) {
          return Scaffold(
            body: const Center(child: Text('Task not found')),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FE),
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context, task, taskProvider),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusCard(task, taskProvider),
                      const SizedBox(height: 20),
                      _buildDetailsCard(task),
                      const SizedBox(height: 20),
                      _buildActionButtons(context, task, taskProvider),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(
      BuildContext context, Task task, TaskProvider taskProvider) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: task.color,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          task.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [task.color, task.color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              task.isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.pending_actions_rounded,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(task: task),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: () async {
            final confirmed = await _showDeleteDialog(context, task);
            if (confirmed) {
              taskProvider.deleteTask(task.id);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildStatusCard(Task task, TaskProvider taskProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => taskProvider.toggleTaskCompletion(task.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: task.isCompleted ? task.color : Colors.transparent,
                border: Border.all(color: task.color, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, size: 40, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.isCompleted ? 'Completed' : 'In Progress',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: task.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.isCompleted
                      ? 'Great job! Task completed'
                      : 'Tap to mark as complete',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(Task task) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 20),

          // Description
          if (task.description.isNotEmpty) ...[
            _buildDetailRow(
              Icons.description_rounded,
              'Description',
              task.description,
              task.color,
            ),
            const SizedBox(height: 16),
          ],

          // Priority
          _buildDetailRow(
            task.getPriorityIcon(),
            'Priority',
            task.getPriorityText(),
            task.color,
          ),
          const SizedBox(height: 16),

          // Created date
          _buildDetailRow(
            Icons.access_time_rounded,
            'Created',
            DateFormat('MMM dd, yyyy - hh:mm a').format(task.createdAt),
            task.color,
          ),

          // Due date
          if (task.dueDate != null) ...[
            const SizedBox(height: 16),
            _buildDetailRow(
              Icons.calendar_today_rounded,
              'Due Date',
              DateFormat('MMM dd, yyyy').format(task.dueDate!),
              task.color,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2D3142),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context, Task task, TaskProvider taskProvider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              taskProvider.toggleTaskCompletion(task.id);
            },
            icon: Icon(
                task.isCompleted ? Icons.refresh_rounded : Icons.check_rounded),
            label: Text(task.isCompleted ? 'Mark Incomplete' : 'Complete Task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: task.color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _showDeleteDialog(BuildContext context, Task task) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Delete Task'),
            content: Text('Are you sure you want to delete "${task.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
