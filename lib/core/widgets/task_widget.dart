import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/pages/edit_screen/edit_view.dart';

import '../../../core/provider/app_provider.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel taskModel;

  const TaskWidget({super.key, required this.taskModel});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Slidable(
        endActionPane: ActionPane(
            extentRatio: 0.24,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (context) {
                  Navigator.pushNamed(context, EditView.routeName,
                      arguments: widget.taskModel);
                },
                borderRadius: BorderRadius.circular(15.0),
                backgroundColor: MyTheme.greyColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ]),
        startActionPane: ActionPane(
            extentRatio: 0.24,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: (context) async {
                  await FireStoreUtils.deleteDataFromFireStore(
                      widget.taskModel);
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
            color: theme.colorScheme.onPrimary,
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
                    color: widget.taskModel.isDone
                        ? MyTheme.greenColor
                        : theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.taskModel.title,
                    style: widget.taskModel.isDone
                        ? TextStyle(color: MyTheme.greenColor)
                        : theme.textTheme.bodyLarge,
                  ),
                  Text(
                    widget.taskModel.description,
                    style: widget.taskModel.isDone
                        ? TextStyle(color: MyTheme.greenColor)
                        : theme.textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 16,
                        color: MyTheme.greyColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '10:30 AM',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  FireStoreUtils.isDone(widget.taskModel);
                  setState(() {});
                },
                child: widget.taskModel.isDone!
                    ? Text(
                        'Done!',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.greenColor),
                      )
                    : Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset('assets/images/check_icon.png'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
