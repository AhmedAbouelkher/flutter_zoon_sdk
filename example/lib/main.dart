import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:example2/player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_sdk/flutter_zoom_sdk.dart';

import '.env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Zoom SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _idController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    if (kDebugMode) {
      _idController.text = "782 8251 7260".replaceAll(" ", "");
      _passwordController.text = "vbk0Ah";
    }

    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VideoPlayer()),
              );
            },
            icon: const Icon(Icons.play_arrow),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'Meeting ID',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  joinMeeting(
                    context,
                    meetingIdController: _idController,
                    passwordController: _passwordController,
                  );
                },
                child: const Text("Join"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void joinMeeting(
  BuildContext context, {
  required TextEditingController meetingIdController,
  required TextEditingController passwordController,
}) {
  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid) {
      result = status == "MEETING_STATUS_DISCONNECTING" || status == "MEETING_STATUS_FAILED";
    } else {
      result = status == "MEETING_STATUS_IDLE";
    }

    return result;
  }

  if (meetingIdController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Enter a valid meeting id to continue."),
    ));
    return;
  }

  ZoomOptions zoomOptions = ZoomOptions(
    domain: "zoom.us",
    appKey: appKey,
    appSecret: appSecret,
    language: "ar-EG",
    disableInvite: true,
    disableRecord: true,
  );
  var meetingOptions = ZoomMeetingOptions(
    userId: 'ahmed', //pass username for join meeting only
    meetingId: meetingIdController.text.trim(), //pass meeting id for join meeting only
    meetingPassword: passwordController.text.trim(), //pass meeting password for join meeting only

    disableDialIn: true,
    disableDrive: true,
    disableInvite: true,
    disableShare: true,
    disableTitleBar: false,
    viewOptions: true,
    noAudio: true,
    noDisconnectAudio: false,
  );

  var zoom = ZoomView();
  late Timer timer;
  zoom.initZoom(zoomOptions).then((results) {
    if (results[0] == 0) {
      zoom.onMeetingStatus().listen((status) {
        log("STATUS: $status");
        debugPrint("${"[Meeting Status Stream] : " + status[0]} - " + status[1]);
        if (_isMeetingEnded(status[0])) {
          print("[Meeting Status] :- Ended");
          timer.cancel();
        }
      });
      debugPrint("listen on event channel");
      zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
        timer = Timer.periodic(const Duration(seconds: 2), (timer) {
          zoom.meetingStatus(meetingOptions.meetingId).then((status) {
            log("POLLED STATUS: ${status[0]}");
            debugPrint("${"[Meeting Status Polling] : " + status[0]} - " + status[1]);
          });
        });
      });
    }
  }).catchError((error) {
    print("[Error Generated] : " + error);
  });
}
