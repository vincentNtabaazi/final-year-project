import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonePaymentController extends StateNotifier<bool> {
  DonePaymentController() : super(false);

  void setState(bool newState) {
    state = newState;
  }
}

final donePaymentControllerProvider =
    StateNotifierProvider<DonePaymentController, bool>((ref) {
  return DonePaymentController();
});
