import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/features/diagnosis/data/fetchData_function.dart';

class DiagnosisRepository {
  const DiagnosisRepository();

  Future<String> fetchDiagnosisResults(Map<dynamic, dynamic> data) async {

    String baseUrl = dotenv.env["BASE_URL_MODEL"]!;

    String response = await fetchDiagnosis(
        "$baseUrl/predictdata", data);

    if (response != "Application Error") {
      return response;
    } else {
      return response;
    }
    
  }
}

final diagnosisRepositoryProvider = Provider<DiagnosisRepository>((ref) {
  return const DiagnosisRepository();
});

final diagnosisResultsFutureProvider = FutureProvider.autoDispose
    .family<String, Map<dynamic, dynamic>>((ref, data) {
  final diagnosisRepository = ref.watch(diagnosisRepositoryProvider);
  return diagnosisRepository.fetchDiagnosisResults(data);
});
