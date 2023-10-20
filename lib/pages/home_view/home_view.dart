import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/network_layer/firestore_utils.dart';
import 'package:todo_app/core/widgets/task_widget.dart';
import 'package:todo_app/model/task_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment(0, 2),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 170,
              width: double.infinity,
              color: theme.colorScheme.primary,
              child: Text(
                AppLocalizations.of(context)!.to_do_list,
                style: theme.textTheme.titleLarge,
              ),
            ),
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(
                days: 365,
              )),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: theme.colorScheme.onSecondary,
              activeDayColor: theme.colorScheme.primary,
              activeBackgroundDayColor: Colors.white,
              dotsColor: theme.primaryColor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            )
          ],
        ),
        const SizedBox(height: 40),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FireStoreUtils.getRealTimeDataFromFireStore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.error.toString()),
                      const SizedBox(height: 20),
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }
                var tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) =>
                      TaskWidget(taskModel: tasksList[index]),
                  itemCount: tasksList.length,
                );
              }),
        )
        /*Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => TaskWidget(),
          itemCount: 10,
        )),*/
      ],
    );
  }
}
