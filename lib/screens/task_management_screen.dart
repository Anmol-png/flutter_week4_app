import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';
import 'task_detail_screen.dart';

class TaskManagementScreen extends StatefulWidget {
  const TaskManagementScreen({super.key});

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Load sample tasks on first run
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (taskProvider.totalTasks == 0) {
        taskProvider.loadSampleTasks();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStatsCards(),
            _buildTabBar(),
            Expanded(child: _buildTaskList()),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return Text(
                      '${taskProvider.activeTasksCount} active tasks',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close_rounded : Icons.search_rounded,
              color: const Color(0xFF6C63FF),
            ),
            onPressed: () {
              setState(() => _isSearching = !_isSearching);
              if (!_isSearching) {
                _searchController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total',
                  taskProvider.totalTasks.toString(),
                  const Color(0xFF6C63FF),
                  Icons.list_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Active',
                  taskProvider.activeTasksCount.toString(),
                  const Color(0xFFFFBE0B),
                  Icons.pending_actions_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Done',
                  taskProvider.completedTasksCount.toString(),
                  const Color(0xFF4ECDC4),
                  Icons.check_circle_rounded,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
      String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6C63FF),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Active'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTaskListView(TaskListType.all),
        _buildTaskListView(TaskListType.active),
        _buildTaskListView(TaskListType.completed),
      ],
    );
  }

  Widget _buildTaskListView(TaskListType type) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        List<Task> tasks;
        switch (type) {
          case TaskListType.active:
            tasks = taskProvider.activeTasks;
            break;
          case TaskListType.completed:
            tasks = taskProvider.completedTasks;
            break;
          default:
            tasks = taskProvider.tasks;
        }

        if (tasks.isEmpty) {
          return _buildEmptyState(type);
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return _buildTaskCard(tasks[index]);
          },
        );
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Dismissible(
      key: Key(task.id),
      background: _buildDismissBackground(
          Alignment.centerLeft, Colors.red, Icons.delete_rounded),
      secondaryBackground: _buildDismissBackground(
          Alignment.centerRight, Colors.green, Icons.check_rounded),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Mark as complete
          Provider.of<TaskProvider>(context, listen: false)
              .toggleTaskCompletion(task.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(task.isCompleted
                  ? 'Task marked as incomplete'
                  : 'Task completed!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        } else {
          // Delete
          return await _showDeleteDialog(task);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(taskId: task.id),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: task.color.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: task.color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Checkbox
                  GestureDetector(
                    onTap: () {
                      Provider.of<TaskProvider>(context, listen: false)
                          .toggleTaskCompletion(task.id);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color:
                            task.isCompleted ? task.color : Colors.transparent,
                        border: Border.all(color: task.color, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: task.isCompleted
                          ? const Icon(Icons.check,
                              size: 16, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Task content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2D3142),
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        if (task.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            task.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Priority badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: task.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(task.getPriorityIcon(),
                            size: 14, color: task.color),
                        const SizedBox(width: 4),
                        Text(
                          task.getPriorityText(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: task.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDismissBackground(
      Alignment alignment, Color color, IconData icon) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: Colors.white, size: 32),
    );
  }

  Widget _buildEmptyState(TaskListType type) {
    String message;
    IconData icon;

    switch (type) {
      case TaskListType.active:
        message = 'No active tasks!';
        icon = Icons.check_circle_outline_rounded;
        break;
      case TaskListType.completed:
        message = 'No completed tasks yet';
        icon = Icons.pending_actions_rounded;
        break;
      default:
        message = 'No tasks yet';
        icon = Icons.add_task_rounded;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTaskScreen()),
        );
      },
      backgroundColor: const Color(0xFF6C63FF),
      icon: const Icon(Icons.add_rounded),
      label: const Text('Add Task'),
    );
  }

  Future<bool> _showDeleteDialog(Task task) async {
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
                onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false)
                      .deleteTask(task.id);
                  Navigator.pop(context, true);
                },
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

enum TaskListType { all, active, completed }
