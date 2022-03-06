import 'package:flutter/material.dart';
import 'package:track_it/pages/loading.dart';
import 'package:track_it/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loading',

      title: 'TRACKIT',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),

      routes: {
        '/loading': (context) => Loading(),
        '/home': (context) => Home(),
      }

    );
  }
}

// const MyHomePage(title: 'Flutter Demo Home Page'),
