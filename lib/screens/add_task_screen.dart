import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task; // If provided, edit mode

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDate;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();

    // If editing, populate fields
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedPriority = widget.task!.priority;
      _selectedDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.task != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Task' : 'New Task'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleField(),
                const SizedBox(height: 20),
                _buildDescriptionField(),
                const SizedBox(height: 20),
                _buildPrioritySelector(),
                const SizedBox(height: 20),
                _buildDueDatePicker(),
                const SizedBox(height: 32),
                _buildSaveButton(isEditMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Container(
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
      child: TextFormField(
        controller: _titleController,
        decoration: InputDecoration(
          labelText: 'Task Title',
          prefixIcon: const Icon(Icons.title_rounded, color: Color(0xFF6C63FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a task title';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
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
      child: TextFormField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Description (Optional)',
          prefixIcon:
              const Icon(Icons.description_rounded, color: Color(0xFF6C63FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Priority',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildPriorityChip(
                TaskPriority.low,
                'Low',
                const Color(0xFF4ECDC4),
                Icons.arrow_downward_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPriorityChip(
                TaskPriority.medium,
                'Medium',
                const Color(0xFFFFBE0B),
                Icons.remove_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPriorityChip(
                TaskPriority.high,
                'High',
                const Color(0xFFFF6584),
                Icons.priority_high_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityChip(
      TaskPriority priority, String label, Color color, IconData icon) {
    final isSelected = _selectedPriority == priority;

    return GestureDetector(
      onTap: () => setState(() => _selectedPriority = priority),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDatePicker() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF6C63FF),
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          setState(() => _selectedDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            const Icon(Icons.calendar_today_rounded, color: Color(0xFF6C63FF)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Due Date',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _selectedDate != null
                        ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                        : 'No due date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedDate != null)
              IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.grey),
                onPressed: () => setState(() => _selectedDate = null),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(bool isEditMode) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          isEditMode ? 'Update Task' : 'Create Task',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    if (widget.task != null) {
      // Edit existing task
      final updatedTask = widget.task!.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _selectedPriority,
        dueDate: _selectedDate,
      );
      taskProvider.updateTask(widget.task!.id, updatedTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task updated successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // Create new task
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _selectedPriority,
        createdAt: DateTime.now(),
        dueDate: _selectedDate,
      );
      taskProvider.addTask(newTask);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task created successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    Navigator.pop(context);
  }
}
