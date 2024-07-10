import 'package:flutter/material.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';
import 'package:medbridge/src/features/video_call/presentation/join_screen.dart';

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String date;
  final String time;
  final bool ready;
  AppointmentCard(
      {super.key,
      required this.doctorName,
      required this.date,
      required this.time})
      : ready = _calculateReady(date);

  static bool _calculateReady(String date) {
    DateTime dueDate = DateTime.parse(date);
    DateTime now = DateTime.now();

    // If the date is not today, return false else true
    if (dueDate.day == now.day && dueDate.month == now.month) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 214, 223, 238)),
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      W(w: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                              size: 17.5,
                              text: doctorName,
                              isBold: true,
                              color: Color.fromARGB(255, 8, 33, 99)),
                          TextCustom(
                            size: 14,
                            text: date,
                            color: Colors.black,
                          ),
                          TextCustom(
                            size: 13,
                            text: "$time (60 min)",
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: ready
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JoinScreen()));
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                    color: ready ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.videocam_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
