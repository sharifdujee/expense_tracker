import 'package:finance_app/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'data/model/add_data.dart';

void main() async {
  /// hive initialize
  await Hive.initFlutter();
  /// adapter registration
  Hive.registerAdapter(AdddataAdapter());
  /// open box
  await Hive.openBox<Add_data>('data');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Bottom(),
    );
  }
}