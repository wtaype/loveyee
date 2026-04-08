import 'package:flutter/material.dart';
import '../wicss.dart';
import '../wiauth/login.dart';
import '../wiauth/auth_fb.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => AuthServicio.estaLogueado ? const PantallaPrincipal() : const PantallaLogin(),
      ));
    });
  }

  @override
  Widget build(BuildContext c) => const Scaffold(
    backgroundColor: AppCSS.bgLight,
    body: Center(child: CircularProgressIndicator(
      strokeWidth: 4, valueColor: AlwaysStoppedAnimation<Color>(AppCSS.white), backgroundColor: AppCSS.primary,
    )),
  );
}
