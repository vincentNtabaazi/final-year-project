import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllDoctorsController extends StateNotifier<List> {
  AllDoctorsController() : super([]);

  void setDoctorList(List newList) {
    state = newList;
  }
}

final alldoctorsControllerProvider =
    StateNotifierProvider<AllDoctorsController, List>((ref) {
  return AllDoctorsController();
});
