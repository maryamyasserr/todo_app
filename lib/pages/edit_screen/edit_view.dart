import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/model/task_model.dart';

class EditView extends StatefulWidget {
  static const String routeName = 'EditScreen';

  EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as TaskModel;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Task',
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyTheme.unselectedColor.withOpacity(0.4),
                  border: Border.all(
                      color: MyTheme.blackColor.withOpacity(0.6), width: 3),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: theme.textTheme.titleMedium!
                            .copyWith(color: Colors.black.withOpacity(0.7)),
                      ),
                      initialValue: arg.title,
                      onChanged: (value) {
                        arg.title = value;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: theme.textTheme.titleMedium!
                            .copyWith(color: Colors.black.withOpacity(0.7)),
                      ),
                      initialValue: arg.description,
                      onChanged: (value) {
                        arg.description = value;
                      },
                    ),
                    SizedBox(height: 60),
                    Text(
                      'Select Date :',
                      style: theme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        showCalender(context);
                      },
                      child: Text(
                        DateFormat.yMMMd().format(arg.dateTime),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        onPressed: () {
                          FireStoreUtils.updateTask(arg);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Edit',
                          style: theme.textTheme.bodyMedium,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void showCalender(BuildContext context) async {
    var dateSelected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (dateSelected == null) {
      return;
    }
    selectedTime = dateSelected;
    setState(() {});
  }
}
