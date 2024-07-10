import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:medbridge/src/common_widgets/custom_snackbar.dart';
import 'package:medbridge/src/features/payments/presentation/done_payment_controller.dart';
import 'package:medbridge/src/features/payments/presentation/pay_button_state_controller.dart';

/// Function to generate random string of characters to act as the transaction
/// reference(txRef) for the flutterwave API
String generateRandomString() {
  const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  String randomString = '';

  for (int i = 0; i < 10; i++) {
    randomString += characters[random.nextInt(characters.length)];
  }

  return randomString;
}

/// Function that directs you to the flutterwave payment portal
/// and consequently update your wallet in the app
void handlePaymentInitialization(
    WidgetRef ref,
    String patientName,
    String? phoneNumber,
    String patientEmail,
    int rate,
    String txRef,
    String patientID,
    String doctorID,
    String time,
    String date,
    BuildContext context) async {
  final Customer customer = Customer(
      name: patientName, phoneNumber: phoneNumber ?? "", email: patientEmail);

  final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: dotenv.env["FLUTTERWAVE_PUBLIC_KEY"]!,
      currency: "UGX",
      redirectUrl: "add-your-redirect-url-here",
      /* the page to display after the trensaction is successful */
      txRef: txRef,
      amount: rate.toString(),
      customer: customer,
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(
          title: "Deposit to mindbridge App",
          description:
              "your deposit amount will reflect on the home screen shortly"),
      isTestMode: true);

  ChargeResponse response = await flutterwave.charge();

  if (response.toJson()["status"] == "successful") {
    try {
      bool value_1 = await createPayment(patientID, doctorID, time, date, rate);

      if (value_1) {
        bool value_2 = await createAppointment(patientID, doctorID, time, date);
        if (value_2) {
          ref.read(donePaymentControllerProvider.notifier).setState(true);
          ref.read(payButtonControllerProvider.notifier).setState(false);
        }
      }
    } catch (error) {
      ref.read(payButtonControllerProvider.notifier).setState(false);

      CustomSnackBar.show(context, "Error updating payments", true);
    }
  } else {
    ref.read(payButtonControllerProvider.notifier).setState(false);

    CustomSnackBar.show(context, "Error with payment. Retry", true);
  }
}

/// Funtion to update the amount in the database to reflect your balance in the app
Future<bool> createAppointment(
    String patientID, String doctorID, String time, String date) async {
  String baseUrl = dotenv.env["BASE_URL_DEV"]!;

  String url = "$baseUrl/appointments/createappointment";

  Map<String, dynamic> data = {
    "patientID": patientID,
    "doctorID": doctorID,
    "time": time,
    "date": date
  };
  var jsonData = jsonEncode(data);

  try {
    await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    );
    // var value = jsonDecode(response.body);

    // var returnValue = value["data"];
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> createPayment(String patientID, String doctorID, String time,
    String date, int rate) async {
  String baseUrl = dotenv.env["BASE_URL_DEV"]!;

  String url = "$baseUrl/payments/addpayment";

  Map<String, dynamic> data = {
    "patientID": patientID,
    "doctorID": doctorID,
    "time": time,
    "date": date,
    "amount": rate
  };
  var jsonData = jsonEncode(data);

  try {
    await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type':
            'application/json', // strictly Add the Content-Type header
      },
    );
    // var value = jsonDecode(response.body);

    // var returnValue = value["data"];
    return true;
  } catch (error) {
    return false;
  }
}
