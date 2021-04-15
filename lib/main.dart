import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'View/Mainapp.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'UPIP ADMIN', home: Mainapp());
  }
}
///flutter build web

////firebase deploy --only hosting:upip-admin