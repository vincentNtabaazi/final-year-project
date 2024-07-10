import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateController extends StateNotifier<List> {
  DateController() : super([]);

  void setList(List newList) {
    var stateList = newList.map((data) {
      String rawDate = data["date"];

      // Parse the input string into a DateTime object
      DateTime date = DateTime.parse(rawDate);

      // Format the date using the desired format
      String monthName = DateFormat('MMM').format(date);
      String dayName = DateFormat('EE').format(date);

      Map<String, dynamic> dateTimeObject = {
        "dayName": dayName.toUpperCase(),
        "time_slots": data["actual_time"],
        "day": date.day.toString(),
        "month": monthName,
        "year": date.year.toString()
      };

      return dateTimeObject;
    }).toList();

    state = stateList;
  }
}

final dateControllerProvider =
    StateNotifierProvider<DateController, List>((ref) {
  return DateController();
});
