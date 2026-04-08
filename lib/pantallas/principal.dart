import 'package:flutter/material.dart';
import '../wicss.dart';
import 'pantalla1/pantalla1.dart';
import 'pantalla2/pantalla2.dart';
import 'pantalla3/pantalla3.dart';
import 'pantalla4/pantalla4.dart';
import 'pantalla5/pantalla5.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _idx = 0;
  late final _pg = PageController();

  static const _pantallas = [
    PantallaRegistrar(), PantallaGastos(), PantallaMensajes(), PantallaArreglar(), PantallaConfiguracion(),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), activeIcon: Icon(Icons.add_circle), label: 'Registrar'),
    BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long), label: 'Gastos'),
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Mensajes'),
    BottomNavigationBarItem(icon: Icon(Icons.verified_outlined), activeIcon: Icon(Icons.verified), label: 'Arreglar'),
    BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Config'),
  ];

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: AppCSS.bgLight,
    body: PageView(controller: _pg, onPageChanged: (i) => setState(() => _idx = i), children: _pantallas),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _idx,
      onTap: (i) { setState(() => _idx = i); _pg.animateToPage(i, duration: AppCSS.trans1, curve: Curves.easeInOut); },
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppCSS.white,
      selectedItemColor: AppCSS.primary,
      unselectedItemColor: AppCSS.gray,
      selectedLabelStyle: AppStyle.sm.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: AppStyle.sm,
      elevation: 10,
      items: _items,
    ),
  );

  @override
  void dispose() { _pg.dispose(); super.dispose(); }
}
