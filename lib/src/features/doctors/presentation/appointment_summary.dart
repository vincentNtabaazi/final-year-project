import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/custom_snackbar.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/selected_date_controller.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/selected_time_controller.dart';
import 'package:medbridge/src/features/doctors/presentation/selected_summary_card.dart';
import 'package:medbridge/src/features/navbar/navbar.dart';
import 'package:medbridge/src/features/payments/data/payment_repository.dart';
import 'package:medbridge/src/features/payments/presentation/done_payment_controller.dart';
import 'package:medbridge/src/features/payments/presentation/pay_button_state_controller.dart';
import 'package:medbridge/src/features/profile/presentation/current_user_controller.dart';
import 'package:http/http.dart' as http;

class AppointmentSummary extends ConsumerStatefulWidget {
  final String doctorName;
  final int rate;
  final String doctorID;
  const AppointmentSummary(
      {super.key,
      required this.doctorName,
      required this.rate,
      required this.doctorID});

  @override
  ConsumerState<AppointmentSummary> createState() => _AppointmentSummaryState();
}

class _AppointmentSummaryState extends ConsumerState<AppointmentSummary> {
  Future<bool> _getTakenTimeslots(
      String doctorID, String selectedDate, String selectedTime) async {
    String baseUrl = dotenv.env["BASE_URL_DEV"]!;

    String url = "$baseUrl/appointments/takentimeslots";

    Map<String, dynamic> data = {"doctorID": doctorID, "date": selectedDate};

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

    var returnValue = value["data"];

    List selectedTimeslotsList = returnValue;

    int evidence = 0;
    for (var element in selectedTimeslotsList) {
      if (element["time"] == selectedTime) {
        evidence++;
      }
    }

    return evidence > 0;
  }

  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    bool donePayment = ref.watch(donePaymentControllerProvider);
    Map currentUser = ref.watch(currentUserControllerProvider);
    String selectedDate = ref.watch(selectedDateControllerProvider);
    String selectedTime = ref.watch(selectedTimeControllerProvider);
    bool payButtonState = ref.watch(payButtonControllerProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: TextCustom(
          text: "Appointment Summary",
          isBold: true,
          size: 19,
          color: Color.fromARGB(255, 8, 33, 99),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            SelectedSummaryCard(
              rate: widget.rate,
              doctorName: widget.doctorName,
              checkmark: donePayment,
            ),
            H(h: 20),
            donePayment
                ? Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Color.fromARGB(255, 30, 153, 34))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          TextCustom(
                            text:
                                "A virtual meeting with Dr ${widget.doctorName} has been scheduled.",
                            isBold: true,
                          ),
                          H(h: 10),
                          TextCustom(
                            text:
                                "A call ID will be sent to your email when the medic begins the call.",
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: MainButton(
                  disabled: payButtonState,
                  text: donePayment ? "Done" : "Process payment",
                  onpressed: () async {
                    ref
                        .read(payButtonControllerProvider.notifier)
                        .setState(true);

                    String txRef = generateRandomString();

                    bool value = await _getTakenTimeslots(
                        widget.doctorID, selectedDate, selectedTime);

                    if (value && !donePayment) {
                      // possible correction here. add another state check for whether donePayment so that the done button takes you to NavBar
                      CustomSnackBar.show(
                          context, "Unavailable: Select different time", true);
                      ref
                          .read(payButtonControllerProvider.notifier)
                          .setState(false);
                    } else {
                      if (!donePayment) {
                        handlePaymentInitialization(
                            ref,
                            currentUser["name"],
                            "",
                            currentUser["email"],
                            widget.rate,
                            txRef,
                            currentUser["patientID"],
                            widget.doctorID,
                            selectedTime,
                            selectedDate,
                            context);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const NavBar()),
                          (Route<dynamic> route) =>
                              false, // Remove all routes from the stack
                        );
                        ref
                            .read(payButtonControllerProvider.notifier)
                            .setState(false);
                        ref
                            .read(payButtonControllerProvider.notifier)
                            .setState(false);
                        ref
                            .read(donePaymentControllerProvider.notifier)
                            .setState(false);
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
