# Task Manager App

A Flutter-based task management app that allows users to create, read, update, and delete tasks.

## Features

- CRUD operations for tasks
- Local data storage using Hive
- Optional API integration for data synchronization
- User-friendly interface with separate layouts for task creation, editing, and viewing
- Task details include title, description, due date, and priority level

## Technical Requirements

- Flutter
- Dart language
- Hive for local data storage
- Provider for state management
- Comprehensive error handling and input validation

## Getting Started

1. **Download the ZIP file.**
   ```sh
   cd task_manager_app
   ```
2. **Open the project in your IDE.**
3. **Install dependencies.**
   ```sh
   flutter pub get
   ```
4. **Run the app.**
   ```sh
   flutter run
   ```


## State Management

This app uses **Provider** for state management. The `TaskProvider` class manages the task data and notifies the UI when changes occur.

## Testing

Unit tests and widget tests are included in the `test` directory. Run the following command to execute the tests:

   ```sh
   flutter test
   ```

## Documentation

This README file provides an overview of the project. For more detailed documentation, please refer to the inline comments in the source code.


