import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'app.dart';
import 'package:hive/hive.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =  await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  if(!Hive.isBoxOpen('user')){
    await Hive.openBox('user');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

