import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackthe6ix/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: App.kPurpleNavy));
  return runApp(App());
}
