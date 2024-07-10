import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/custom_snackbar.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/doctors/presentation/appointment_summary.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/date_of_selected_doctor_controller.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/selected_date_controller.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/selected_time_controller.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/time_slots_controller.dart';

class BookAppointment extends ConsumerStatefulWidget {
  final String doctorName;
  final String proTitle;
  final String hospitalName;
  final int rate;
  final String doctorID;
  final Map? avatar;

  const BookAppointment(
      {super.key,
      required this.doctorName,
      required this.avatar,
      required this.hospitalName,
      required this.doctorID,
      required this.proTitle,
      required this.rate});

  @override
  ConsumerState<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends ConsumerState<BookAppointment> {
  @override
  void initState() {
    super.initState();
    _value = null;
    _time_value = null;
  }

  int? _value;
  int? _time_value;
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
        String baseUrl = dotenv.env["BASE_URL_DEV"]!;

    List timeslotsProvider =
        ref.watch(timeslotsControllerProvider(widget.doctorID));
    List dateProvider = ref.watch(dateControllerProvider);

    String selectedDate = ref.watch(selectedDateControllerProvider);
    String selectedTime = ref.watch(selectedTimeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: TextCustom(
          text: "Book an appointment",
          isBold: true,
          size: 19,
          color: Color.fromARGB(255, 8, 33, 99),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
            child: TextCustom(text: "Medic"),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 8, 33, 99),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 56,
                      width: 56,
                      child: ClipOval(
                        child: widget.avatar != null
                            ? Image.network(
                                "$baseUrl/uploads/${widget.avatar!["file_name"]}",
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: LinearProgressIndicator(
                                      color: Color(0xFF082163),
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )
                            : Image.asset("assets/images/placeholder.jpg"),
                      ),
                    ),
                    W(w: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          size: 18,
                          text: "Dr ${widget.doctorName}",
                          isBold: true,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            "${widget.proTitle}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 197, 197, 197),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        TextCustom(
                          size: 15,
                          text: "Virtual Session (60 min)",
                          color: Color.fromARGB(255, 197, 197, 197),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 0),
            child: TextCustom(text: "Available dates"),
          ),
          Container(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List<Widget>.generate(
                    dateProvider.length,
                    (int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: ChoiceChip(
                          padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                          backgroundColor: Color.fromARGB(255, 223, 230, 248),
                          labelStyle: TextStyle(
                            color: _value == index
                                ? Colors.white
                                : Color.fromARGB(255, 8, 33, 99),
                          ),
                          selectedColor: Color.fromARGB(255, 8, 33, 99),
                          disabledColor: Color.fromARGB(255, 223, 230, 248),
                          labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadiusDirectional.circular(50)),
                          side: BorderSide(
                              color: Color.fromARGB(255, 149, 172, 230)),
                          showCheckmark: false,
                          label: ConstrainedBox(
                              constraints:
                                  BoxConstraints(minWidth: 50, maxWidth: 60),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(dateProvider[index]["month"]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(
                                      dateProvider[index]["day"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Text(
                                    dateProvider[index]["dayName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              )),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                            });
                            ref
                                .read(selectedDateControllerProvider.notifier)
                                .setDate(selected
                                    ? "${dateProvider[index]["dayName"]}, ${dateProvider[index]["day"]} ${dateProvider[index]["month"]} ${dateProvider[index]["year"]}"
                                    : "");
                            ref
                                .read(
                                    timeslotsControllerProvider(widget.doctorID)
                                        .notifier)
                                .setList(selected
                                    ? dateProvider[index]["time_slots"]
                                    : []);
                          },
                        ),
                      );
                    },
                  ).toList(),
                )),
          ),
          !timeslotsProvider.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 30, bottom: 0),
                  child: TextCustom(text: "Select time"),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 5,
                    children: List<Widget>.generate(
                      timeslotsProvider.length,
                      (int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ChoiceChip(
                            padding: EdgeInsets.fromLTRB(8, 7, 8, 7),
                            backgroundColor: Color.fromARGB(255, 223, 230, 248),
                            labelStyle: TextStyle(
                              color: _time_value == index
                                  ? Colors.white
                                  : Color.fromARGB(255, 8, 33, 99),
                            ),
                            selectedColor: Color.fromARGB(255, 8, 33, 99),
                            disabledColor: Color.fromARGB(255, 223, 230, 248),
                            labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 149, 172, 230)),
                            showCheckmark: false,
                            label: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 100),
                              child: Text(
                                timeslotsProvider[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            selected: _time_value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _time_value = selected ? index : null;
                              });
                              ref
                                  .read(selectedTimeControllerProvider.notifier)
                                  .setTime(selected
                                      ? "${timeslotsProvider[index]}"
                                      : "");
                            },
                          ),
                        );
                      },
                    ).toList(),
                  )),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            child: MainButton(
                disabled: disabled,
                text: "Confirm",
                onpressed: () {
                  setState(() {
                    _value = null;
                    _time_value = null;
                  });
                  if (selectedTime.isEmpty || selectedDate.isEmpty) {
                    CustomSnackBar.show(context, "Select date and time", true);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentSummary(
                                  doctorID: widget.doctorID,
                                  doctorName: widget.doctorName,
                                  rate: widget.rate,
                                )));
                  }
                }),
          )
        ],
      ),
    );
  }
}
