import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackthe6ix/app.dart';

List<CameraDescription> cameraDescriptions;

Future<void> main() async {
  cameraDescriptions = await availableCameras();
  print(cameraDescriptions);
  return runApp(App());
}
