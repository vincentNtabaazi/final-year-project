import 'package:flutter/material.dart';
import 'package:medbridge/src/common_widgets/main_button.dart';
import 'package:medbridge/src/features/video_call/data/api_call.dart';

import 'meeting_screen.dart';

class JoinScreen extends StatelessWidget {
  final _meetingIdController = TextEditingController();

  JoinScreen({super.key});

  void onJoinButtonPressed(BuildContext context) {
    String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    // check meeting id is not null or invaild
    // if meeting id is vaild then navigate to MeetingScreen with meetingId,token
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid call id"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MindBridge'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Join the call",
                      style:
                          TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Call ID is sent to your email at time of call",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter Call ID',
                  border: OutlineInputBorder(),
                ),
                controller: _meetingIdController,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: MainButton(
                    text: "Join now",
                    onpressed: () {
                      onJoinButtonPressed(context);
                    })),
          ],
        ),
      ),
    );
  }
}
