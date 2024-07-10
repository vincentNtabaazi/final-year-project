import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultDoctorsController extends StateNotifier<List> {
  SearchResultDoctorsController() : super([]);

  void setDoctorList(List newList) {
    state = newList;
  }
}

final searchResultControllerProvider =
    StateNotifierProvider<SearchResultDoctorsController, List>((ref) {
  return SearchResultDoctorsController();
});
