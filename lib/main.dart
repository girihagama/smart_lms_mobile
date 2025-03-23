import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/inventory_view.dart';
import 'package:smart_lms/view/landing_screen.dart';
import 'package:smart_lms/view/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the rootgit credential reject https://github.com of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LandingScreen(),
    );
  }
}

