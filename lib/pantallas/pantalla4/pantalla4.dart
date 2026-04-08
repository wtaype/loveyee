import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaMensajes extends StatelessWidget {
  const PantallaMensajes({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Mensajes'),
    backgroundColor: AppCSS.bgLight,
    body: Center(child: Container(
      margin: AppCSS.padM, padding: AppCSS.padL,
      decoration: AppCSS.glass500,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        wiIconCircle(Icons.chat_bubble),
        AppCSS.gapM,
        Text('Bienvenido a Mensajes', style: AppStyle.h3.copyWith(color: AppCSS.primary)),
        AppCSS.gapS,
        Text('Chatea con tus amigos 💬', style: AppStyle.bd, textAlign: TextAlign.center),
      ]),
    )),
  );
}
