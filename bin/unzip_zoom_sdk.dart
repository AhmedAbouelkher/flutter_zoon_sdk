import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

void main(List<String> args) async {
  var location = Platform.script.toString();
  var isNewFlutter = location.contains(".snapshot");
  if (isNewFlutter) {
    var sp = Platform.script.toFilePath();
    var sd = sp.split(Platform.pathSeparator);
    sd.removeLast();
    var scriptDir = sd.join(Platform.pathSeparator);
    var packageConfigPath = [scriptDir, '..', '..', '..', 'package_config.json'].join(Platform.pathSeparator);
    var jsonString = File(packageConfigPath).readAsStringSync();
    Map<String, dynamic> packages = jsonDecode(jsonString);
    var packageList = packages["packages"];
    String? zoomFileUri;

    for (var package in packageList) {
      if (package["name"] == "flutter_zoom_sdk") {
        zoomFileUri = package["rootUri"];
        break;
      }
    }

    if (zoomFileUri == null) {
      debugPrint("flutter_zoom_sdk package not found!");
      return;
    }
    location = zoomFileUri;
  }

  if (Platform.isWindows) {
    location = location.replaceFirst("file:///", "");
  } else {
    location = location.replaceFirst("file://", "");
  }
  if (!isNewFlutter) {
    location = location.replaceFirst("/bin/unzip_zoom_sdk.dart", "");
  }

  await checkAndDownloadSDK(location);
}

Future<void> checkAndDownloadSDK(String location) async {
  await Future.wait([
    // IOS
    downloadIOS(location),

    // Android
    downloadAndroid(location),
  ]);

  debugPrint("Download completed!");
}

Future<void> downloadIOS(String location) async {
  final iosSDKFile = location + '/ios/MobileRTC.xcframework/ios-arm64_armv7/MobileRTC.framework/MobileRTC';
  bool exists = await File(iosSDKFile).exists();

  if (!exists) {
    await downloadFile(Uri.parse('https://www.dropbox.com/s/a5vfh2m543t15k8/MobileRTC?dl=1'), iosSDKFile);
  }

  final iosSimulateSDKFile =
      location + '/ios/MobileRTC.xcframework/ios-i386_x86_64-simulator/MobileRTC.framework/MobileRTC';
  exists = await File(iosSimulateSDKFile).exists();

  if (!exists) {
    await downloadFile(Uri.parse('https://www.dropbox.com/s/alk03qxiolurxf8/MobileRTC?dl=1'), iosSimulateSDKFile);
  }
}

Future<void> downloadAndroid(String location) async {
  final androidCommonLibFile = location + '/android/libs/commonlib.aar';
  bool exists = await File(androidCommonLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse('https://www.dropbox.com/s/bzdp4qydybkjxlh/commonlib.aar?dl=0&raw=1'), androidCommonLibFile);
  }

  final androidRTCLibFile = location + '/android/libs/mobilertc.aar';
  exists = await File(androidRTCLibFile).exists();
  if (!exists) {
    await downloadFile(
        Uri.parse('https://www.dropbox.com/s/knhobkd4tilgzre/mobilertc.aar?dl=0&raw=1'), androidRTCLibFile);
  }
}

Future<void> downloadFile(Uri uri, String savePath) async {
  final _client = HttpClient();

  debugPrint('Download ${uri.toString()} to $savePath');

  File destinationFile = await File(savePath).create(recursive: true);

  final request = await _client.getUrl(uri);
  final response = await request.close();

  await response.pipe(destinationFile.openWrite());

  _client.close();
}
