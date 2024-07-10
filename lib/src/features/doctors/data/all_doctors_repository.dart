import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/all_doctors_controller.dart';

class AllDoctorsRepository {
  const AllDoctorsRepository();

  Future<List> getallDoctors(AllDoctorsController allDoctorsController) async {
    // String url = "http://192.168.43.145:3000/alldoctors/getalldoctors";
    // String url = "http://localhost:3000/alldoctors/getalldoctors";

    String baseUrl = dotenv.env["BASE_URL_DEV"]!;


    String url =
        "$baseUrl/alldoctors/getalldoctors";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    );
    var value = jsonDecode(response.body);

    var returnValue = value["data"];
    allDoctorsController.setDoctorList(returnValue);
    return returnValue;
  }
}

final alldoctorsRepositoryProvider = Provider<AllDoctorsRepository>((ref) {
  return const AllDoctorsRepository();
});

final getalldoctorsFutureProvider = FutureProvider.autoDispose<List>((ref) {
  final alldoctorsRepository = ref.watch(alldoctorsRepositoryProvider);
  var allDoctorsController = ref.read(alldoctorsControllerProvider.notifier);
  return alldoctorsRepository.getallDoctors(allDoctorsController);
});
