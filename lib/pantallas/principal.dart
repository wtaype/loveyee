import 'package:flutter/material.dart';
import '../wicss.dart';
import 'pantalla1/inicio.dart';
import 'pantalla2/prevencion.dart';
import 'pantalla3/alimentos.dart';
import 'pantalla4/tratamiento.dart';
import 'pantalla5/acerca.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _idx = 0;
  late final _pg = PageController();

  static const _pantallas = [
    PantallaInicio(), PantallaPrevencion(), PantallaAlimentos(), PantallaTratamiento(), PantallaAcerca(),
  ];

  static const _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.shield_outlined), activeIcon: Icon(Icons.shield), label: 'Prevención'),
    BottomNavigationBarItem(icon: Icon(Icons.restaurant_outlined), activeIcon: Icon(Icons.restaurant), label: 'Alimentos'),
    BottomNavigationBarItem(icon: Icon(Icons.healing_outlined), activeIcon: Icon(Icons.healing), label: 'Tratamiento'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Acerca'),
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
