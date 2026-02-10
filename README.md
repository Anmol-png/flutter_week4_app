# 🚀 Flutter Week 6 - Provider State Management & Task Manager

A complete **Task Management App** with **Provider state management**, building on Weeks 4-6 to create a production-ready Flutter application.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.0%2B-blue.svg)](https://flutter.dev/)
[![Provider](https://img.shields.io/badge/State%20Management-Provider-green.svg)](https://pub.dev/packages/provider)

---

## ✅ Week 6 Requirements - All Implemented!

### 1. Introduction to Provider ✅
- ✅ Implemented Provider package for state management
- ✅ Created TaskProvider with ChangeNotifier
- ✅ Replaced setState with Provider throughout app
- ✅ Real-time UI updates based on state changes

### 2. Task Management App with Provider ✅
- ✅ Add tasks with title, description, priority, due date
- ✅ Update/Edit existing tasks
- ✅ Delete tasks (swipe to delete)
- ✅ Mark tasks as complete/incomplete
- ✅ Filter tasks (All, Active, Completed)
- ✅ Real-time statistics (total, active, completed)

### 3. Final Enhancements & Optimization ✅
- ✅ Performance optimization using Provider best practices
- ✅ Beautiful UI/UX with smooth animations
- ✅ Fade-in animations on screens
- ✅ Swipe gestures (left: delete, right: complete)
- ✅ Animated checkboxes and priority chips
- ✅ Hero animations (planned for expansion)

---

## ✨ Features

### 🎯 Task Management
- **Create Tasks**: Title, description, priority (Low/Medium/High), due date
- **Edit Tasks**: Update any task details
- **Delete Tasks**: Swipe left or use detail screen
- **Complete Tasks**: Swipe right or tap checkbox
- **Filter Tasks**: View all, active, or completed tasks
- **Sort Tasks**: By priority or date
- **Search Tasks**: Find tasks by title or description

### 📊 Statistics Dashboard
- Total tasks count
- Active tasks count
- Completed tasks count
- Completion rate percentage
- Color-coded stats cards

### 🎨 Beautiful UI
- Modern Material Design 3
- Color-coded priorities:
  - 🔴 High Priority (Pink #FF6584)
  - 🟡 Medium Priority (Yellow #FFBE0B)
  - 🔵 Low Priority (Cyan #4ECDC4)
- Smooth animations throughout
- Responsive design
- Intuitive gestures

### ⚡ State Management with Provider
- Centralized state management
- Automatic UI updates
- No unnecessary rebuilds
- Clean architecture
- Scalable code structure

---

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry with Provider setup
├── models/
│   ├── task_model.dart               # Task data model
│   └── user_model.dart               # User model (Week 4)
├── providers/
│   └── task_provider.dart            # Task state management
├── services/
│   ├── api_service.dart              # API calls (Week 4)
│   └── auth_service.dart             # Firebase Auth (Week 5)
└── screens/
    ├── task_management_screen.dart   # Main task list screen
    ├── add_task_screen.dart          # Add/Edit task screen
    ├── task_detail_screen.dart       # Task details screen
    ├── home_screen.dart              # API users (Week 4)
    ├── login_screen.dart             # Firebase auth (Week 5)
    ├── signup_screen.dart            # Firebase auth (Week 5)
    └── firebase_profile_screen.dart  # User profile (Week 5)
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0+)
- Provider package (6.1.1)
- All Week 4 & 5 dependencies

### Installation

1. **Get dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run -d windows
   ```

3. **Navigate to Task Manager**
   - Login (or signup) with Firebase
   - On home screen, tap the **Task icon** (📋)
   - Start managing your tasks!

---

## 📦 New Dependencies (Week 6)

```yaml
dependencies:
  provider: ^6.1.1      # State management
  intl: ^0.18.1         # Date formatting
```

---

## 🎯 How to Use

### Creating a Task

1. Tap the **"Add Task"** floating button
2. Enter task title (required)
3. Add description (optional)
4. Select priority (Low, Medium, High)
5. Set due date (optional)
6. Tap **"Create Task"**

### Managing Tasks

**Complete a Task:**
- Swipe right → Mark as complete
- Or tap the checkbox

**Delete a Task:**
- Swipe left → Delete
- Or tap task → Delete button

**Edit a Task:**
- Tap on task → Edit button
- Update details → Save

**View Task Details:**
- Tap on any task card
- See full details, edit, or delete

### Filtering Tasks

Use the tabs at the top:
- **All**: See all tasks
- **Active**: Only incomplete tasks
- **Completed**: Only finished tasks

---

## 🔥 Provider Implementation

### 1. Task Provider (State Management)

```dart
class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  
  // Getters
  List<Task> get tasks => [..._tasks];
  List<Task> get activeTasks => _tasks.where((t) => !t.isCompleted).toList();
  
  // Actions
  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners(); // Updates UI automatically
  }
  
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
```

### 2. Provider Setup (main.dart)

```dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

### 3. Consuming Provider (UI)

```dart
// Method 1: Consumer widget (rebuilds only this widget)
Consumer<TaskProvider>(
  builder: (context, taskProvider, child) {
    return Text('Tasks: ${taskProvider.totalTasks}');
  },
)

// Method 2: Provider.of (for actions, no rebuild)
Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
```

---

## 🎨 UI/UX Animations

### 1. Fade-in Animation
```dart
FadeTransition(
  opacity: _fadeAnimation,
  child: TaskList(),
)
```

### 2. Animated Checkbox
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  decoration: BoxDecoration(
    color: task.isCompleted ? color : Colors.transparent,
  ),
)
```

### 3. Priority Chip Animation
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  decoration: BoxDecoration(
    color: isSelected ? color : Colors.white,
    boxShadow: isSelected ? [...] : [],
  ),
)
```

### 4. Swipe Gestures
```dart
Dismissible(
  key: Key(task.id),
  background: DeleteBackground(),
  secondaryBackground: CompleteBackground(),
  onDismissed: (direction) => handleSwipe(direction),
)
```

---

## 📊 Features Breakdown

| Feature | Implementation | Provider Used |
|---------|---------------|---------------|
| Add Task | ✅ Form with validation | `taskProvider.addTask()` |
| Edit Task | ✅ Pre-filled form | `taskProvider.updateTask()` |
| Delete Task | ✅ Swipe gesture | `taskProvider.deleteTask()` |
| Complete Task | ✅ Checkbox toggle | `taskProvider.toggleTaskCompletion()` |
| Filter Tasks | ✅ Tabs (All/Active/Done) | `taskProvider.activeTasks` |
| Statistics | ✅ Real-time counts | `Consumer<TaskProvider>` |
| Animations | ✅ Smooth transitions | AnimatedContainer |

---

## 🏗️ Provider Architecture

### State Management Flow:

```
User Action
    ↓
UI (Screen/Widget)
    ↓
Provider Method Call
    ↓
State Update
    ↓
notifyListeners()
    ↓
UI Rebuild (automatically)
    ↓
Updated Screen
```

### Example: Adding a Task

```
1. User taps "Create Task"
2. AddTaskScreen calls taskProvider.addTask(newTask)
3. TaskProvider adds task to list
4. TaskProvider calls notifyListeners()
5. All Consumer<TaskProvider> widgets rebuild
6. UI shows new task automatically
```

---

## ✅ Week 6 Deliverables Checklist

- [x] Provider package integrated
- [x] TaskProvider with ChangeNotifier
- [x] Task model with all properties
- [x] Add task functionality
- [x] Edit task functionality
- [x] Delete task functionality
- [x] Toggle completion functionality
- [x] Filter tasks (All/Active/Completed)
- [x] Real-time statistics
- [x] Beautiful UI with animations
- [x] Swipe gestures
- [x] Performance optimized
- [x] Clean code architecture
- [x] GitHub-ready repository

---

## 🧪 Testing the App

### Test Add Task:
1. Open Task Manager
2. Tap "Add Task"
3. Fill in details
4. Tap "Create Task"
5. ✅ Task appears in list

### Test Complete Task:
1. Swipe task right
2. ✅ Task marked complete
3. ✅ Moves to "Completed" tab

### Test Delete Task:
1. Swipe task left
2. Confirm deletion
3. ✅ Task removed from list

### Test Edit Task:
1. Tap on task
2. Tap edit icon
3. Update details
4. ✅ Changes saved

### Test Statistics:
1. Add tasks
2. Complete some tasks
3. ✅ Statistics update in real-time

---

## 🎓 Learning Outcomes

By completing Week 6, you've learned:

### Provider Concepts:
- ✅ ChangeNotifier pattern
- ✅ MultiProvider setup
- ✅ Consumer widget
- ✅ Provider.of() method
- ✅ listen: false vs true
- ✅ notifyListeners()

### Best Practices:
- ✅ Separation of concerns
- ✅ State management architecture
- ✅ Performance optimization
- ✅ Clean code structure
- ✅ Reusable widgets

### Flutter Skills:
- ✅ Animations (Fade, Container)
- ✅ Gestures (Swipe, Tap)
- ✅ Forms and validation
- ✅ Navigation
- ✅ Custom widgets

---

## 📚 Provider Best Practices Used

### 1. **Use Consumer for UI updates**
✅ Only widgets that need updates are rebuilt

### 2. **Use listen: false for actions**
✅ Prevents unnecessary rebuilds

### 3. **Keep models immutable**
✅ Used copyWith() method

### 4. **Centralize business logic**
✅ All task operations in TaskProvider

### 5. **Use getters for computed values**
✅ activeTasksCount, completionRate, etc.

---

## 🚀 Performance Optimizations

### 1. **Selective Rebuilds**
- Used Consumer widget
- Only affected widgets rebuild
- No full screen rebuilds

### 2. **Immutable Data**
- Tasks use copyWith()
- No direct mutations
- Predictable state changes

### 3. **Efficient Lists**
- ListView.builder for large lists
- Keys for Dismissible widgets
- Const widgets where possible

### 4. **Animation Performance**
- AnimationController with SingleTickerProviderStateMixin
- Proper disposal of controllers
- Optimized durations (200-800ms)

---


## 📄 License

This project is created for educational purposes as part of the Flutter Developers Internship Program.

---

## 🙏 Acknowledgments

- [Provider Package](https://pub.dev/packages/provider)
- [Flutter Documentation](https://flutter.dev/docs)
- [Material Design 3](https://m3.material.io/)
- Flutter Developers Internship Program

---

## 🎯 Complete Project Summary

### Week 4: API Integration ✅
- HTTP requests
- JSON parsing
- Users list
- Error handling

### Week 5: Firebase Authentication ✅
- Email/Password auth
- Firestore database
- User profiles
- Auth state management

### Week 6: Provider & Task Management ✅
- Provider state management
- Task CRUD operations
- Beautiful animations
- Performance optimization

---

**Made with ❤️ using Flutter & Provider**

**🎉 All 3 weeks complete - Ready for submission!**

