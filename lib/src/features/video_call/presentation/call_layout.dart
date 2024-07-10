import 'package:flutter/material.dart';
import 'package:medbridge/src/features/video_call/presentation/participant_tile.dart';

class CallLayout extends StatefulWidget {
   const CallLayout({super.key, required this.participantTile1, required this.participantTile2});

  final ParticipantTile participantTile1;
  final Widget participantTile2;

  @override
  State<CallLayout> createState() => _CallLayoutState();
}

class _CallLayoutState extends State<CallLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Center(
              child: widget.participantTile2)),
        Positioned(
            bottom: 20,
            left: 20,
            child: Center(
              child: SizedBox(
                height: 200,
                width: 150,
                child: widget.participantTile1,
              ),
            ))
      ],
    );
  }
}
