import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaySelectionGrid extends StatelessWidget {
  final List<List<bool>> isSelected = List.generate(
    5, // 5 columns (weeks)
        (_) => List.filled(7, false), // 7 rows (days)
  ).obs;

  DaySelectionGrid({super.key});

  void toggleCircle(int week, int day) {
    isSelected[week][day] = !isSelected[week][day];
  }

  List<List<String>> getSelectedDays() {
    final daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<List<String>> selectedDays = [];

    for (int week = 0; week < isSelected.length; week++) {
      List<String> weekSelection = [];
      for (int day = 0; day < isSelected[week].length; day++) {
        if (isSelected[week][day]) {
          weekSelection.add(daysOfWeek[day]);
        }
      }
      selectedDays.add(weekSelection);
    }
    return selectedDays;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (week) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (day) {
            return Obx(() => GestureDetector(
              onTap: () => toggleCircle(week, day),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: isSelected[week][day]
                    ? Colors.green
                    : Colors.grey[300],
              ),
            ));
          }),
        );
      }),
    );
  }
}
