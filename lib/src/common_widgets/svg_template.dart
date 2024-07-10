import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVG extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final Color color;
  const SVG(
      {super.key,
      required this.assetName,
      required this.height,
      required this.width,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/$assetName",
      width: width,
      height: height,
      color: color,
    );
  }
}
