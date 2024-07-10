import 'package:flutter/material.dart';

class H extends StatelessWidget {
  final double h;
  const H({super.key, required this.h});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}


class W extends StatelessWidget {
  final double w;
  const W({super.key, required this.w});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
    );
  }
}
