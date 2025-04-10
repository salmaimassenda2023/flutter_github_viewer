import 'package:flutter/material.dart';
import 'package:flutter_github_viewer/pages/home.page.dart';
import 'package:flutter_github_viewer/pages/users.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes: {
        // "/repos":(context)=>GitRepoPages(),
        "/users": (context)=>UserPage()
      },
      initialRoute: "/users",
    );
  }
}



