import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayButtonController extends StateNotifier<bool> {
  PayButtonController() : super(false);

  void setState(bool newState) {
    state = newState;
  }
}

final payButtonControllerProvider =
    StateNotifierProvider<PayButtonController, bool>((ref) {
  return PayButtonController();
});
