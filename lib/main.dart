import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ride/authentication/requestcode.dart';
import 'package:ride/map.dart';

import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RIDE',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      // home: OtpRequest(),
      home: OtpRequest(),
    );
  }
}
