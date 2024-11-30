import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app_kevin_salazar/firebase_options.dart';

import 'app.dart';


void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // run app
  runApp(MyApp());
}


