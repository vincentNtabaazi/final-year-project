import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medbridge/src/features/history/data/all_questions.dart';

class PastDiagnosesController extends StateNotifier<List> {
  PastDiagnosesController() : super([]);

  void setList(List newlist) {
    state = newlist;
    // create a map with question as key and response as value
    List newStateList = newlist.map((element_1) {
      List incomingKeys = element_1.keys.toList();
      List questionkeys = allQuestions.keys.toList();
      Map questionResponse_2 = {};
      Map questionResponse = {};
      for (int i = 0; i < incomingKeys.length; i++) {
        for (int j = 0; j < questionkeys.length; j++) {
          if (incomingKeys[i] == questionkeys[j]) {
            questionResponse[allQuestions[questionkeys[j]]] =
                element_1[incomingKeys[i]];
          }
        }
      }
      questionResponse_2["q&a"] = questionResponse;
      questionResponse_2["result"] = element_1["result"];
      questionResponse_2["createdAt"] = DateFormat('EE, M/d/y')
          .format(DateTime.parse(element_1["createdAt"]));
      return questionResponse_2;
    }).toList();
    state = newStateList;
  }
}

final pastDiagnosesControllerProvider =
    StateNotifierProvider<PastDiagnosesController, List>((ref) {
  return PastDiagnosesController();
});
