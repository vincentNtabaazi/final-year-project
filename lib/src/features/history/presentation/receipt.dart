import 'package:flutter/material.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:medbridge/src/common_widgets/svg_template.dart';
import 'package:medbridge/src/common_widgets/text_template.dart';


class Receipt extends StatelessWidget {
  final String doctorName;
  final int rate;
  final bool checkmark;
  final String date;
  final String time;
  const Receipt(
      {super.key,
      this.checkmark = false,
      required this.doctorName,
      required this.rate,
      required this.date,
      required this.time});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              color: Color.fromARGB(255, 223, 230, 248)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: "Virtual Session",
                      isBold: true,
                      color: Color.fromARGB(255, 8, 33, 99),
                    ),
                    TextCustom(
                      text: "Dr $doctorName",
                      isBold: true,
                    ),
                    H(h: 10),
                    TextCustom(
                      text: date,
                      size: 15,
                    ),
                    TextCustom(
                      text: "${time}",
                      size: 15,
                    ),
                  ],
                ),
                checkmark
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SVG(
                          assetName: "checkmark.svg",
                          height: 20,
                          width: 20,
                          color: Color.fromARGB(255, 30, 153, 34),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
              color: Color.fromARGB(255, 8, 33, 99)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(
                  text: "Rate",
                  color: Colors.white,
                ),
                TextCustom(
                  text: "Ugx $rate",
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
