import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';
import '../../models/task.dart';
import '../../utils/colors.dart';
import '../../utils/constanst.dart';
import '../../view/home/widgets/task_widget.dart';
import '../../view/tasks/task_view.dart';
import '../../utils/strings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int checkDoneTask(List<Task> task) {
    int i = 0;
    for (Task doneTasks in task) {
      if (doneTasks.isCompleted) {
        i++;
      }
    }
    return i;
  }

  dynamic valueOfTheIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return 'LOW';
      case 2:
        return 'MEDIUM';
      case 3:
        return 'HIGH';
      default:
        return 'UNKNOWN';
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    var textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();
          tasks.sort(((a, b) => a.createdAtDate.compareTo(b.createdAtDate)));

          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: const FAB(),
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              toolbarHeight: 100,
              leadingWidth: 200, // Give enough width for the text
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    MyString.appBarText,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      box.isEmpty
                          ? warningNoTask(context)
                          : deleteAllTask(context);
                    },
                    child: const Icon(
                      CupertinoIcons.trash,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),            body: _buildBody(tasks, base, textTheme),
          );
        });
  }

  SizedBox _buildBody(
      List<Task> tasks,
      BaseWidget base,
      TextTheme textTheme,
      ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.secondaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
            width: double.infinity,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyString.mainTitle, style: textTheme.displayLarge),
                    const SizedBox(height: 3),
                    Text(
                      "${checkDoneTask(tasks)} of ${tasks.length} ${tasks.length == 1 ? 'task' : 'tasks'}",
                      style:
                      textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 55,
            ),
          ),
          Expanded(
            child: tasks.isNotEmpty
                ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                var task = tasks[index];

                return Dismissible(
                  direction: DismissDirection.horizontal,
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8),
                      Text(MyString.deletedTask,
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  onDismissed: (direction) {
                    base.dataStore.dalateTask(task: task);
                  },
                  key: Key(task.id),
                  child: TaskWidget(
                    task: task,
                    priorityText: _getPriorityText(task.priority),
                    priorityColor: _getPriorityColor(task.priority),
                  ),
                );
              },
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeIn(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      lottieURL,
                      animate: tasks.isNotEmpty ? false : true,
                        frameRate: FrameRate.max
                    ),
                  ),
                ),
                FadeInUp(
                  from: 30,
                  child: const Text(MyString.doneAllTask),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Floating Action Button
class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => TaskView(
              taskControllerForSubtitle: null,
              taskControllerForTitle: null,
              task: null,
            ),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: MyColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

/// difficulty labels


class PriorityLabel extends StatelessWidget {
  final String label;
  final Color color;

  const PriorityLabel({Key? key, required this.label, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: TextTheme().headlineSmall?.fontSize,
        ),
      ),
    );
  }
}
