import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaArreglar extends StatelessWidget {
  const PantallaArreglar({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Arreglar Datos'),
    backgroundColor: AppCSS.bgLight,
    body: Center(child: Container(
      margin: AppCSS.padM, padding: AppCSS.padL,
      decoration: AppCSS.glass500,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        wiIconCircle(Icons.build_circle),
        AppCSS.gapM,
        Text('Bienvenido a Arreglar', style: AppStyle.h3.copyWith(color: AppCSS.primary)),
        AppCSS.gapS,
        Text('Actualiza tus datos personales 🔧', style: AppStyle.bd, textAlign: TextAlign.center),
      ]),
    )),
  );
}
