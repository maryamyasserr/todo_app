import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/model/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: MyTheme.redColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (context) async {
                  await FireStoreUtils.deleteDataFromFireStore(taskModel);
                },
                borderRadius: BorderRadius.circular(15.0),
                backgroundColor: MyTheme.redColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: Container(
          height: 115,
          width: 400,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    taskModel.title,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    taskModel.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Icon(Icons.alarm, size: 16),
                      SizedBox(width: 5),
                      Text(
                        '10:30 AM',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset('assets/images/check_icon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
