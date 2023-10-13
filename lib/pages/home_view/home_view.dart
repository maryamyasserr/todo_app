import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/widgets/task_widget.dart';

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
              color: theme.primaryColor,
              child: Text(
                'To Do List',
                style: theme.textTheme.titleLarge,
              ),
            ),
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(
                days: 365,
              )),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: theme.primaryColor,
              activeBackgroundDayColor: Colors.white,
              dotsColor: theme.primaryColor,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            )
          ],
        ),
        const SizedBox(height: 40),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => TaskWidget(),
          itemCount: 10,
        )),
      ],
    );
  }
}
