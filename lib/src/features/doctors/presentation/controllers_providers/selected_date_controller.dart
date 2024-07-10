import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDateController extends StateNotifier<String> {
  SelectedDateController() : super("");

  void setDate(String newdate) {
    state = newdate;
  }
}

final selectedDateControllerProvider =
    StateNotifierProvider<SelectedDateController, String>((ref) {
  return SelectedDateController();
});
