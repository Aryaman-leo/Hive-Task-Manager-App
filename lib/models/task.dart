import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.createdAtTime,
      required this.createdAtDate,
      required this.isCompleted,
      required this.priority});

  /// ID
  @HiveField(0)
  final String id;

  /// TITLE
  @HiveField(1)
  String title;

  /// SUBTITLE
  @HiveField(2)
  String subtitle;

  /// CREATED AT TIME
  @HiveField(3)
  DateTime createdAtTime;

  /// CREATED AT DATE
  @HiveField(4)
  DateTime createdAtDate;

  /// IS COMPLETED
  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  int priority;

  /// create new Task
  factory Task.create({
    required String? title,
    required String? subtitle,
    required int? priority,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subtitle: subtitle ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        isCompleted: false,
        priority: priority ?? 0,
        createdAtDate: createdAtDate ?? DateTime.now(),
      );
}
