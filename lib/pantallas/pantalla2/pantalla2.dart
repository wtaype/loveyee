import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaGastos extends StatelessWidget {
  const PantallaGastos({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Mis Gastos'),
    backgroundColor: AppCSS.bgLight,
    body: Center(child: Container(
      margin: AppCSS.padM, padding: AppCSS.padL,
      decoration: AppCSS.glass500,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        wiIconCircle(Icons.receipt_long),
        AppCSS.gapM,
        Text('Bienvenido a Gastos', style: AppStyle.h3.copyWith(color: AppCSS.primary)),
        AppCSS.gapS,
        Text('Ve todos tus gastos registrados 📊', style: AppStyle.bd, textAlign: TextAlign.center),
      ]),
    )),
  );
}
