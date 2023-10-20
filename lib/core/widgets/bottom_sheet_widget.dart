import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.onPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale!.add_new_task,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              CustomTextFormField(
                title: locale!.enter_your_task_title,
                controller: titleController,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return locale!.you_must_enter_task_title;
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextFormField(
                title: locale!.enter_your_task_description,
                controller: descriptionController,
                maxLines: 4,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return locale!.you_must_enter_task_description;
                  } else {
                    return null;
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    locale!.select_time,
                    style: theme.textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCalender(context);
                    },
                    child: Text(
                      DateFormat.yMMMd().format(selectedTime),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
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
                  locale!.add_task,
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
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
