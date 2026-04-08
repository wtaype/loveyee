import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantallas/principal.dart';
import 'wicss.dart';
import 'wii.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    theme: AppStyle.tema, home: const PantallaPrincipal(),
  );
}
