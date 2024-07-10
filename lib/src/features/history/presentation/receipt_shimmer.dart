import 'package:flutter/material.dart';
import 'package:medbridge/src/common_widgets/sizedbox_template.dart';

import 'package:shimmer/shimmer.dart';

class ReceiptShimmer extends StatelessWidget {
  const ReceiptShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: const Color.fromARGB(88, 245, 245, 245),
                      child: Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ),
                    H(h: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: const Color.fromARGB(88, 245, 245, 245),
                      child: Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ),
                    H(h: 20),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 150,
                        color: Colors.grey,
                      ),
                    ),
                    H(h: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 40,
            width: double.maxFinite,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
