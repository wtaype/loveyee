import 'package:flutter/material.dart';
import '../wicss.dart';
import '../pantallas/principal.dart';

class PantallaCargando extends StatefulWidget {
  const PantallaCargando({super.key});
  @override
  State<PantallaCargando> createState() => _PantallaCargandoState();
}

class _PantallaCargandoState extends State<PantallaCargando> {
  @override
  void initState() {
    super.initState();
    // Ir directo a la pantalla principal después de 1 segundo
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => const PantallaPrincipal(),
      ));
    });
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: AppCSS.primary,
    body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo circular
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppCSS.white,
            boxShadow: AppCSS.shadow,
          ),
          child: ClipOval(child: AppCSS.logo),
        ),
        const SizedBox(height: 24),
        const CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(AppCSS.white),
        ),
      ],
    )),
  );
}
