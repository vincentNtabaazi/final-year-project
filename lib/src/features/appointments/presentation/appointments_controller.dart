import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentsController extends StateNotifier<List> {
  AppointmentsController() : super([]);

  void setList(List newlist) {
    state = newlist;
  }
}

final appointmentsControllerProvider =
    StateNotifierProvider<AppointmentsController, List>((ref) {
  return AppointmentsController();
});
