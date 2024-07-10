import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/features/diagnosis/domain/diagnosis_class.dart';

class DiagnosisController extends StateNotifier<Diagnosis> {
  DiagnosisController()
      : super(Diagnosis("", "", "", "", "", "", "", "", "", "", "", "", "", "",
            "", "", ""));

  void updateDiagnosis(String option, String symptom) {
    String unique_option = option;

    if (option == "Never") {
      unique_option = "Seldom";
    }

    switch (symptom) {
      case 'sadness':
        state = state.copyWith(sadness: unique_option);
        break;
      case 'euphoric':
        state = state.copyWith(euphoric: unique_option);
        break;
      case 'exhausted':
        state = state.copyWith(exhausted: unique_option);
        break;
      case 'sleep_dissorder':
        state = state.copyWith(sleep_dissorder: unique_option);
        break;
      case 'mood_swing':
        state = state.copyWith(mood_swing: option);
        break;
      case 'suicidal_thoughts':
        state = state.copyWith(suicidal_thoughts: option);
        break;
      case 'anorxia':
        state = state.copyWith(anorxia: option);
        break;
      case 'authority_respect':
        state = state.copyWith(authority_respect: option);
        break;
      case 'try_explanation':
        state = state.copyWith(try_explanation: option);
        break;
      case 'aggressive_response':
        state = state.copyWith(aggressive_response: option);
        break;
      case 'ignore_and_move_on':
        state = state.copyWith(ignore_and_move_on: option);
        break;
      case 'nervous_break_down':
        state = state.copyWith(nervous_break_down: option);
        break;
      case 'admit_mistakes':
        state = state.copyWith(admit_mistakes: option);
        break;
      case 'overthinking':
        state = state.copyWith(overthinking: option);
        break;
      case 'sexual_activity':
        state = state.copyWith(sexual_activity: option);
        break;
      case 'concentration':
        state = state.copyWith(concentration: option);
        break;
      case 'optimism':
        state = state.copyWith(optimisim: option);
        break;
      default:
        // Handle unknown symptom
        print('Unknown symptom: $symptom');
        break;
    }
  }

  void killDiagnosisState() {
    state = Diagnosis(
        "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
  }
}

final diagnosisControllerProvider =
    StateNotifierProvider<DiagnosisController, Diagnosis>((ref) {
  return DiagnosisController();
});
