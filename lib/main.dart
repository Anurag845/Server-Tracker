import 'package:flutter/material.dart';
import 'package:server_tracker/servers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Server Tracker',
      debugShowCheckedModeBanner: false,
      home: Servers(),
    );
  }
}

