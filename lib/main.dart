import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'homePage.dart';

void main() async {

  //initialize hive
  await Hive.initFlutter();

  //open a box
  var box=await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
    );
  }
}

