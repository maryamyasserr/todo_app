import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/widgets/custom_text_form_field.dart';
import 'package:todo_app/model/task_model.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  static TextEditingController titleController = TextEditingController();

  static TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!.copyWith(color: Colors.black),
            ),
            CustomTextFormField(
              title: 'Enter Your Task Title',
              controller: titleController,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'you must enter task title';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              title: 'Enter Your Task Description',
              controller: descriptionController,
              maxLines: 4,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'you must enter task description';
                } else {
                  return null;
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Select Time',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    showCalender(context);
                  },
                  child: Text(
                    DateFormat.yMMMd().format(selectedTime),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var model = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      dateTime: DateTime.now(),
                      isDone: false);
                  await FireStoreUtils.addDataToFireStore(model);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Task',
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCalender(BuildContext context) async {
    var dateSelected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (dateSelected == null) {
      return;
    }
    selectedTime = dateSelected;
    setState(() {});
  }
}
