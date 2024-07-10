import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeslotsController extends StateNotifier<List> {
  final String doctorID;
  TimeslotsController({required this.doctorID}) : super([]);

  void setList(List newList) async {
    state = newList;
  }
}

final timeslotsControllerProvider =
    StateNotifierProvider.family<TimeslotsController, List, String>(
        (ref, doctorID) {
  return TimeslotsController(doctorID: doctorID);
});
