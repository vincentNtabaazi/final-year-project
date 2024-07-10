import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/doctors/presentation/book_appointment.dart';
import 'package:medbridge/src/features/doctors/presentation/controllers_providers/date_of_selected_doctor_controller.dart';

class DoctorCard extends ConsumerStatefulWidget {
  final List timeSlots;
  final String doctorName;
  final String doctorID;
  final String proTitle;
  final String hospitalName;
  final String languagesSPoken;
  final int rate;
  final String medSpecialty;
  final Map? avatar;
  const DoctorCard(
      {super.key,
      required this.doctorName,
      required this.proTitle,
      required this.doctorID,
      required this.languagesSPoken,
      required this.rate,
      required this.medSpecialty,
      required this.timeSlots,
      required this.hospitalName,
      required this.avatar});

  @override
  ConsumerState<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends ConsumerState<DoctorCard> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
            String baseUrl = dotenv.env["BASE_URL_DEV"]!;

    return InkWell(
      onTap: () {
        expand
            ? setState(() {
                expand = false;
              })
            : setState(() {
                expand = true;
              });
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Color.fromARGB(255, 116, 124, 146), width: 0.5)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
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
                        text: "Dr ${widget.doctorName}",
                        size: 18,
                        isBold: true,
                        color: Color.fromARGB(255, 8, 33, 99),
                      ),
                      TextCustom(text: widget.proTitle),
                      TextCustom(text: widget.hospitalName),
                      H(h: 10),
                      TextCustom(
                        text: widget.timeSlots.isEmpty
                            ? "Earliest slot: -- "
                            : "Earliest slot:  ${widget.timeSlots[0]["date"]}  ${widget.timeSlots[0]["actual_time"][0]}",
                        size: 14,
                        color: Color.fromARGB(255, 122, 122, 122),
                      )
                    ],
                  )
                ],
              ),
              expand
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        H(h: 20),
                        TextCustom(
                          text: "Professional profile",
                          isBold: true,
                        ),
                        // H(h: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              widget.medSpecialty.split(",").length,
                              (index) => TextCustom(
                                text: widget.medSpecialty
                                    .split(",")[index]
                                    .trim(),
                                size: 14,
                                color: Color.fromARGB(255, 122, 122, 122),
                              ),
                            ).toList()),
                        H(h: 10),
                        TextCustom(
                          text: "Languages: ${widget.languagesSPoken}",
                          size: 14,
                        ),
                        H(h: 10),
                        TextCustom(
                          text: "Rate: Ugx ${widget.rate}",
                          isBold: true,
                          size: 14,
                        ),
                        H(h: 15),
                        MainButton(
                            text: "Select",
                            onpressed: () {
                              ref
                                  .read(dateControllerProvider.notifier)
                                  .setList(widget.timeSlots);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookAppointment(
                                            avatar: widget.avatar,
                                            doctorID: widget.doctorID,
                                            doctorName: widget.doctorName,
                                            hospitalName: widget.hospitalName,
                                            proTitle: widget.proTitle,
                                            rate: widget.rate,
                                          )));
                            })
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
