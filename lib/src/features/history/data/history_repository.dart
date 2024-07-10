import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:medbridge/src/features/history/presentation/past_diagnoses_controller.dart';

class HistoryRepository {
  const HistoryRepository();

  Future<bool> getDiagnosis(
      PastDiagnosesController pastDiagnosesController, String patientID) async {
                String baseUrl = dotenv.env["BASE_URL_DEV"]!;

    String url =
        "$baseUrl/diagnosis/getdiagnoses";

    Map<String, dynamic> data = {
      "patientID": patientID,
    };

    var jsonData = jsonEncode(data);
    final response = await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    );
    var value = jsonDecode(response.body);

    pastDiagnosesController.setList(value["data"]);
    return true;
  }

  Future<List> getPayments(String patientID) async {
            String baseUrl = dotenv.env["BASE_URL_DEV"]!;

    String url =
        "$baseUrl/payments/getpayments";

    Map<String, dynamic> data = {
      "patientID": patientID,
    };
    var jsonData = jsonEncode(data);
    final response = await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    );
    var value = jsonDecode(response.body);

    return value["data"];
  }
}

final pastDiagnosissRepositoryProvider = Provider<HistoryRepository>((ref) {
  return const HistoryRepository();
});

final getpastdiagnosisListFutureProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, patientID) {
  final pastDiagnosisRepository = ref.watch(pastDiagnosissRepositoryProvider);
  final pastDiagnosesController =
      ref.read(pastDiagnosesControllerProvider.notifier);

  return pastDiagnosisRepository.getDiagnosis(
      pastDiagnosesController, patientID);
});

final getPatmentsListFutureProvider =
    FutureProvider.autoDispose.family<List, String>((ref, patientID) {
  final historyRepository = ref.watch(pastDiagnosissRepositoryProvider);
  return historyRepository.getPayments(patientID);
});
