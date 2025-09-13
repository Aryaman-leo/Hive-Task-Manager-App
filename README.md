# 🚀 Hive Task Manager App

<div align="center">
  <img src="assets/icon/app_icon.png" alt="Task Manager App Icon" width="120" height="120">
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![Hive](https://img.shields.io/badge/Hive-FF6B35?style=for-the-badge&logo=hive&logoColor=white)](https://hivedb.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
</div>

## 📋 Overview

A sophisticated **Flutter-based Task Management Application** built with modern architecture patterns and best practices. This app demonstrates advanced Flutter development skills, clean architecture implementation, and efficient local data persistence using Hive database.

### ✨ Key Features

- **📝 Complete CRUD Operations** - Create, Read, Update, and Delete tasks seamlessly
- **🎯 Priority Management** - Three-tier priority system (High, Medium, Low) with visual indicators
- **📅 Date & Time Management** - Intuitive date/time pickers with formatted display
- **✅ Task Completion Tracking** - Visual completion status with animated transitions
- **🗑️ Smart Deletion** - Swipe-to-delete functionality with confirmation dialogs
- **🎨 Modern UI/UX** - Beautiful animations, gradients, and responsive design
- **💾 Local Data Persistence** - Fast and reliable Hive database integration
- **🔄 Real-time Updates** - Reactive UI with ValueListenableBuilder pattern

## 🏗️ Architecture & Technical Excellence

### **Clean Architecture Implementation**

```
lib/
├── 📁 data/           # Data Layer - Hive Database Operations
├── 📁 models/         # Domain Models with Hive Annotations
├── 📁 utils/          # Utility Classes (Colors, Strings, Constants)
├── 📁 view/           # Presentation Layer
│   ├── 📁 home/       # Home Screen & Widgets
│   └── 📁 tasks/      # Task Creation/Editing Screens
└── main.dart          # App Entry Point with Dependency Injection
```

### **Advanced Flutter Patterns**

#### 🎯 **State Management**
- **InheritedWidget Pattern** for dependency injection
- **ValueListenableBuilder** for reactive UI updates
- **Custom BaseWidget** for global state access

#### 🗄️ **Data Persistence**
- **Hive Database** for lightweight, fast local storage
- **Type-safe Adapters** with code generation
- **Automatic data cleanup** (removes tasks from previous days)

#### 🎨 **UI/UX Excellence**
- **Custom Theme System** with comprehensive text themes
- **Animated Transitions** using `animate_do` package
- **Lottie Animations** for empty states
- **Material Design 3** principles
- **Responsive Layout** with proper constraints

## 🛠️ Technical Stack

### **Core Technologies**
- **Flutter 3.6.1+** - Cross-platform UI framework
- **Dart** - Programming language
- **Hive 1.1.0** - Lightweight NoSQL database

### **Key Dependencies**
```yaml
dependencies:
  hive_flutter: ^1.1.0          # Local database
  uuid: ^3.0.5                  # Unique ID generation
  intl: ^0.17.0                 # Internationalization
  animate_do: ^2.1.0            # Smooth animations
  lottie: ^1.4.0                # Vector animations
  flutter_datetime_picker_plus: ^2.1.0  # Date/time selection
  flutter_beautiful_popup: ^1.7.0       # Custom dialogs
  panara_dialogs: ^0.1.2        # Beautiful dialog system
  ftoast: ^2.0.0                # Toast notifications
```

### **Development Tools**
- **build_runner** - Code generation
- **hive_generator** - Hive adapter generation
- **flutter_lints** - Code quality enforcement

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK 3.6.1 or higher
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hive-task-manager-app.git
   cd hive-task-manager-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 🎯 Key Implementation Highlights

### **1. Advanced Data Model**
```dart
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) String title;
  @HiveField(2) String subtitle;
  @HiveField(3) DateTime createdAtTime;
  @HiveField(4) DateTime createdAtDate;
  @HiveField(5) bool isCompleted;
  @HiveField(6) int priority;
  
  factory Task.create({...}) => Task(
    id: const Uuid().v1(),
    // ... other parameters
  );
}
```

### **2. Clean Data Layer**
```dart
class HiveDataStore {
  static const boxName = "tasksBox";
  final Box<Task> box = Hive.box<Task>(boxName);
  
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }
  
  ValueListenable<Box<Task>> listenToTask() {
    return box.listenable();
  }
}
```

### **3. Reactive UI Pattern**
```dart
ValueListenableBuilder(
  valueListenable: base.dataStore.listenToTask(),
  builder: (ctx, Box<Task> box, Widget? child) {
    var tasks = box.values.toList();
    // UI updates automatically when data changes
  }
)
```

### **4. Custom Theme System**
```dart
theme: ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black, fontSize: 45),
    titleMedium: TextStyle(color: Colors.grey, fontSize: 16),
    // ... comprehensive text theme
  ),
)
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

## 📦 Build & Deployment

### **Android APK**
```bash
flutter build apk --release
```

### **iOS**
```bash
flutter build ios --release
```

## 🎨 Design System

### **Color Palette**
- **Primary**: `#4568dc` (Blue)
- **Secondary**: `#b06ab3` (Purple)
- **Priority Colors**:
  - High: Red (`#E53935`)
  - Medium: Orange (`#FB8C00`)
  - Low: Green (`#43A047`)

### **Typography**
- Comprehensive text theme with 8 different text styles
- Consistent font weights and sizes
- Proper color contrast ratios

## 🔧 Configuration

### **App Icon**
The app includes a custom launcher icon configured in `pubspec.yaml`:
```yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
```

### **Assets Structure**
```
assets/
├── icon/          # App launcher icons
├── img/           # Screenshots and images
└── lottie/        # Animation files
```

## 🚀 Performance Optimizations

- **Efficient List Rendering** with `ListView.builder`
- **Memory Management** with proper controller disposal
- **Optimized Animations** using `AnimatedContainer`
- **Lazy Loading** for better performance
- **Automatic Data Cleanup** to prevent storage bloat

## 🎯 Skills Demonstrated

### **Flutter Expertise**
- ✅ Advanced Widget Composition
- ✅ Custom State Management
- ✅ Reactive Programming Patterns
- ✅ Material Design Implementation
- ✅ Animation & Transition Design
- ✅ Performance Optimization

### **Architecture & Design**
- ✅ Clean Architecture Principles
- ✅ Separation of Concerns
- ✅ Dependency Injection
- ✅ SOLID Principles
- ✅ Code Organization & Structure

### **Data Management**
- ✅ Local Database Integration
- ✅ Type-safe Data Models
- ✅ CRUD Operations
- ✅ Data Validation
- ✅ Error Handling

### **UI/UX Design**
- ✅ Modern Material Design
- ✅ Responsive Layout Design
- ✅ Accessibility Considerations
- ✅ User Experience Optimization
- ✅ Visual Feedback Systems

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Sagar** - *Full Stack Flutter Developer*

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Portfolio: [Your Portfolio](https://yourportfolio.com)

---

<div align="center">
  <p>⭐ Star this repository if you found it helpful!</p>
  <p>Made with ❤️ using Flutter</p>
</div>
