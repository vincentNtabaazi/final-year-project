import 'package:flutter/material.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentShimmer extends StatelessWidget {
  const AppointmentShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Color.fromARGB(255, 116, 124, 146), width: 0.5)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 200,
                        color: Colors.grey,
                      ),
                    ),
                    H(h: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ),
                    H(h: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
