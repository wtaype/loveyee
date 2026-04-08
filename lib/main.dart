import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'inicio/cargando.dart';
import 'wicss.dart';
import 'wii.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppCSS.bgLight, systemNavigationBarColor: AppCSS.bgLight,
  ));
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    title: wii.app, debugShowCheckedModeBanner: false,
    theme: AppStyle.tema, home: const PantallaCargando(),
  );
}
