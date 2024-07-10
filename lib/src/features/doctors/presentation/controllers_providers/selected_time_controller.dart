import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedTimeController extends StateNotifier<String> {
  SelectedTimeController() : super("");

  void setTime(String newdate) {
    state = newdate;
  }
}

final selectedTimeControllerProvider =
    StateNotifierProvider<SelectedTimeController, String>((ref) {
  return SelectedTimeController();
});
