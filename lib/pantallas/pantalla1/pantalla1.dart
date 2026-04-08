import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaRegistrar extends StatelessWidget {
  const PantallaRegistrar({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Registrar Gasto'),
    backgroundColor: AppCSS.bgLight,
    body: Center(child: Container(
      margin: AppCSS.padM, padding: AppCSS.padL,
      decoration: AppCSS.glass500,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        wiIconCircle(Icons.add_circle_outline),
        AppCSS.gapM,
        Text('Bienvenido al Registro', style: AppStyle.h3.copyWith(color: AppCSS.primary)),
        AppCSS.gapS,
        Text('Registra tus gastos fácilmente 💰', style: AppStyle.bd, textAlign: TextAlign.center),
      ]),
    )),
  );
}
