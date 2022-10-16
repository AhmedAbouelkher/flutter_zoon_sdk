import 'dart:async';
import 'package:flutter/services.dart';

import '../flutter_zoom_sdk.dart';

class ZoomView extends ZoomPlatform {
  final MethodChannel channel = const MethodChannel('com.ahmed/zoom_sdk');

  /// The event channel used to interact with the native platform.
  final EventChannel eventChannel = const EventChannel('com.ahmed/zoom_sdk_event_stream');

  /// The event channel used to interact with the native platform init function
  @override
  Future<List> initZoom(ZoomOptions options) async {
    var optionMap = <String, String?>{};

    if (options.appKey != null) {
      optionMap.putIfAbsent("appKey", () => options.appKey!);
    }
    if (options.appSecret != null) {
      optionMap.putIfAbsent("appSecret", () => options.appSecret!);
    }

    optionMap.putIfAbsent("domain", () => options.domain);
    return await channel.invokeMethod<List>('init', optionMap).then<List>((List? value) => value ?? List.empty());
  }

  /// The event channel used to interact with the native platform startMeetingNormal function
  @override
  Future<List> startMeetingNormal(ZoomMeetingOptions options) async {
    return await channel
        .invokeMethod<List>('startNormal', options.toMap())
        .then<List>((List? value) => value ?? List.empty());
  }

  /// The event channel used to interact with the native platform joinMeeting function
  @override
  Future<bool> joinMeeting(ZoomMeetingOptions options) async {
    return await channel.invokeMethod<bool>('join', options.toMap()).then<bool>((bool? value) => value ?? false);
  }

  /// The event channel used to interact with the native platform startMeeting(login on iOS & Android) function
  @override
  Future<List> startMeeting(ZoomMeetingOptions options) async {
    throw UnimplementedError("startMeeting is not implemented");
  }

  /// The event channel used to interact with the native platform meetingStatus function
  @override
  Future<List> meetingStatus(String meetingId) async {
    var optionMap = <String, String>{};
    optionMap.putIfAbsent("meetingId", () => meetingId);

    return await channel
        .invokeMethod<List>('meeting_status', optionMap)
        .then<List>((List? value) => value ?? List.empty());
  }

  /// The event channel used to interact with the native platform onMeetingStatus(iOS & Android) function
  @override
  Stream<dynamic> onMeetingStatus() {
    return eventChannel.receiveBroadcastStream();
  }

  /// The event channel used to interact with the native platform meetingDetails(iOS & Android) function
  @override
  Future<List> meetingDetails() async {
    return await channel.invokeMethod<List>('meeting_details').then<List>((List? value) => value ?? List.empty());
  }
}
