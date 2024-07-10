import 'package:flutter/material.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;
  final bool micEnabled;
  final bool cameraEnabled;

  const MeetingControls(
      {super.key,
      required this.cameraEnabled,
      required this.micEnabled,
      required this.onToggleMicButtonPressed,
      required this.onToggleCameraButtonPressed,
      required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onLeaveButtonPressed,
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(15)),
            child: const Icon(
              Icons.phone,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: onToggleCameraButtonPressed,
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 51, 51),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              cameraEnabled
                  ? Icons.video_call_rounded
                  : Icons.videocam_off_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: onToggleMicButtonPressed,
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 51, 51),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              micEnabled ? Icons.mic_rounded : Icons.mic_off,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
