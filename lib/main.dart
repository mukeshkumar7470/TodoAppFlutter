import 'package:flutter/material.dart';
import 'Screens/custom_tab_bar.dart';
import 'Screens/home_page_new.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      theme: ThemeData(
          canvasColor: Colors.white, accentColor: Colors.blueAccent),
      home: HomePage(),
    );
  }
}
