import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task.dart';
import '../../../utils/colors.dart';
import '../../../view/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.priorityText,
    required this.priorityColor,
  });

  final Task task;
  final String priorityText;
  final Color priorityColor;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subtitle;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              taskControllerForTitle: taskControllerForTitle,
              taskControllerForSubtitle: taskControllerForSubtitle,
              task: widget.task,
            ),
          ),
        );
      },

      /// Main Card
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border:
                Border(left: BorderSide(color: widget.priorityColor, width: 4)),
            color: widget.task.isCompleted
                ? const Color.fromARGB(154, 119, 144, 229)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ],
          ),
          child: Stack(
            children: [
              /// **Task ListTile**
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20), // Adjusted for icon placement
                child: ListTile(
                  /// **Title**
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 3),
                    child: Text(
                      taskControllerForTitle.text,
                      style: TextStyle(
                        color: widget.task.isCompleted
                            ? MyColors.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: widget.task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),

                  /// **Description, Priority & Date**
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// **Task Description**
                      Text(
                        taskControllerForSubtitle.text,
                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? MyColors.primaryColor
                              : const Color.fromARGB(255, 164, 164, 164),
                          fontWeight: FontWeight.w300,
                          decoration: widget.task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),

                      /// **Priority Text**
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.priorityText,
                          style: TextStyle(
                            color: widget.task.isCompleted
                                ? Colors.white
                                : widget.priorityColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// **Date & Time**
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('hh:mm a')
                                    .format(widget.task.createdAtTime),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: widget.task.isCompleted
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                              Text(
                                DateFormat.yMMMEd()
                                    .format(widget.task.createdAtDate),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: widget.task.isCompleted
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// **Check Icon at Top Left**
              Positioned(
                top: 11,
                left: 7,
                child: GestureDetector(
                  onTap: () {
                    widget.task.isCompleted = !widget.task.isCompleted;
                    widget.task.save();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.task.isCompleted
                          ? MyColors.primaryColor
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 0.8),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
