import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BarIcon extends StatefulWidget {
  final String name;
  final bool active;
  const BarIcon({super.key, required this.name, required this.active});

  @override
  State<BarIcon> createState() => _BarIconState();
}

class _BarIconState extends State<BarIcon> {
  @override
  Widget build(BuildContext context) {
    switch (widget.name) {
      case 'Doctors':
        return SvgPicture.asset(
          'assets/images/medic.svg',
          height: 35,
          width: 35,
          color: widget.active
              ? Color.fromARGB(255, 8, 33, 99)
              : const Color.fromARGB(255, 108, 108, 109),
        );

      case 'Appointments':
        return SvgPicture.asset(
          'assets/images/appointments.svg',
          height: 26,
          width: 26,
          color: widget.active
              ? Color.fromARGB(255, 8, 33, 99)
              : Color.fromARGB(255, 108, 108, 109),
        );

      case 'History':
        return SvgPicture.asset(
          'assets/images/history.svg',
          height: 26,
          width: 26,
          color: widget.active
              ? Color.fromARGB(255, 8, 33, 99)
              : const Color.fromARGB(255, 108, 108, 109),
        );
      case 'Profile':
        return SvgPicture.asset(
          'assets/images/profile.svg',
          height: 25,
          width: 25,
          color: widget.active
              ? Color.fromARGB(255, 8, 33, 99)
              : const Color(0xFFA9A8AA),
        );
    }

    return const Scaffold();
  }
}
