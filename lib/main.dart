import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:LifeLine/screens/homepage.dart';

void main() {
  runApp(MyApp());
  debugPaintSizeEnabled = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todas Task",
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
