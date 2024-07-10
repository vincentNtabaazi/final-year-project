import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medbridge/src/features/navbar/navbar.dart';
import 'package:medbridge/src/features/video_call/presentation/call_layout.dart';
import 'package:medbridge/src/features/video_call/presentation/meeting_controls.dart';
import 'package:videosdk/videosdk.dart';

import './participant_tile.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;

  Room? useRoom;
  List<Participant> joinedParticipant = [];

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
        roomId: widget.meetingId,
        token: widget.token,
        displayName: "John Doe",
        micEnabled: micEnabled,
        camEnabled: camEnabled,
        defaultCameraIndex: kIsWeb
            ? 0
            : 1 // Index of MediaDevices will be used to set default camera
        );
    useRoom = _room;
    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    // _room.on(Events.roomJoined, () {

    // });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(() {
          joinedParticipant.add(participant);
        });
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      setState(() {
        joinedParticipant.clear();
      });
      // if (participants.containsKey(participantId)) {
      //   setState(
      //     () => participants.remove(participantId),
      //   );
      // }
    });

    _room.on(Events.roomLeft, () {
      joinedParticipant.clear();
      // participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    // _room.leave();
    return false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              //render all participant
              Expanded(
                child: CallLayout(
                    participantTile1: ParticipantTile(
                        key: Key(useRoom!.localParticipant.id),
                        participant: useRoom!.localParticipant),
                    participantTile2: joinedParticipant.isEmpty
                        ? Container(
                            color: Colors.grey.shade800,
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                size: 100,
                              ),
                            ),
                          )
                        : ParticipantTile(
                            key: Key(joinedParticipant[0].id),
                            participant: joinedParticipant[0])),
              ),
              Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MeetingControls(
                    micEnabled: micEnabled,
                    cameraEnabled: camEnabled,
                    onToggleMicButtonPressed: () {
                      micEnabled ? _room.muteMic() : _room.unmuteMic();
                      setState(() {
                        micEnabled = !micEnabled;
                      });
                    },
                    onToggleCameraButtonPressed: () {
                      camEnabled ? _room.disableCam() : _room.enableCam();
                      setState(() {
                        camEnabled = !camEnabled;
                      });
                    },
                    onLeaveButtonPressed: () {
                      _room.leave();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => NavBar()),
                        (Route<dynamic> route) =>
                            false, // Remove all routes from the stack
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
