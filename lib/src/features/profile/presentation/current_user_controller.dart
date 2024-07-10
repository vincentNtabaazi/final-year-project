import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentUserController extends StateNotifier<Map> {
  CurrentUserController() : super({});

  void setUser(Map newUser) {
    state = newUser;
  }

  void killUserState() {
    state = {};
  }
}

final currentUserControllerProvider =
    StateNotifierProvider<CurrentUserController, Map>((ref) {
  return CurrentUserController();
});
