mport 'dart:io';

import 'package:basic_app/providers/my_http_overrides.dart';
import 'package:basic_app/ui/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}
