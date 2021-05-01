import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:paisabachao/utils/initialbindings.dart';
import 'package:paisabachao/utils/routes.dart';
import 'package:paisabachao/utils/theme.dart';
import 'package:paisabachao/utils/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      title: 'Paisa Bachao',
      theme: theme(),
      home: Wrapper(),
    );
  }
}
