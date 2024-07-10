import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String assetName;
  final double radius;
  const Avatar({super.key, required this.assetName, this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: Image.asset(
        "assets/images/$assetName",
        fit: BoxFit.cover,
      ).image,
    );
  }
}
