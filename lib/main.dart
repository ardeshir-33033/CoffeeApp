import 'package:flutter/material.dart';

import 'CoffeeConcept.dart';
import 'Main_Coffee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Theme(data: ThemeData.light(), child: MainCoffee()));
  }
}
