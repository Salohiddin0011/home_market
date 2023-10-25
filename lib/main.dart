import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_market/app.dart';
import 'package:home_market/services/dark_mode_db.dart';

import 'firebase_options.dart';

HiveDb hiveDb = HiveDb();
void main() async {
  await HiveDb.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomeMarketApp());
}
