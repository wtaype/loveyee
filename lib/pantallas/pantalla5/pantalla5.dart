// Cache integrado para configuración: memoria + SharedPreferences (95% ahorro Firebase)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../wicss.dart';
import '../../wii.dart';
import '../../widev.dart';
import '../../wiauth/auth_fb.dart';
import '../../wiauth/login.dart';
import '../../wiauth/usuario.dart';
import '../../wiauth/firestore_fb.dart';

class PantallaConfiguracion extends StatefulWidget {
  const PantallaConfiguracion({super.key});
  @override
  State<PantallaConfiguracion> createState() => _PantallaConfiguracionState();
}

class _PantallaConfiguracionState extends State<PantallaConfiguracion> {
  // 🎯 Cache estático
  static Usuario? _usuarioCache;
  static DateTime? _fechaCache;
  static const _expira = Duration(hours: 6);
  static const _kUser = 'usuario_cache', _kFecha = 'fecha_cache';

  final _ctrlFoto = TextEditingController();
  bool _load = false, _loadUser = true;
  Usuario? _user;

  @override
  void initState() { super.initState(); _cargarUsuario(); }

  // 📱 Cargar usuario con cache
  _cargarUsuario() async {
    setState(() => _loadUser = true);
    try {
      _user = await _obtenerConCache();
      if (_user?.foto?.isNotEmpty == true) _ctrlFoto.text = _user!.foto!;
    } catch (e) {
      if (mounted) Notificacion.err(context, 'Error: $e');
    } finally {
      if (mounted) setState(() => _loadUser = false);
    }
  }

  // 🧠 Cache 3 niveles: memoria → storage → firebase
  Future<Usuario?> _obtenerConCache() async {
    if (!AuthServicio.estaLogueado) return null;
    final email = AuthServicio.usuarioActual!.email!;

    // 1. Memoria
    if (_usuarioCache != null && _cacheOk()) return _usuarioCache;

    // 2. Storage
    final uStorage = await _deStorage();
    if (uStorage != null && _cacheOk()) return _usuarioCache = uStorage;

    // 3. Firebase
    final uFb = await DatabaseServicio.obtenerUsuarioPorEmail(email);
    if (uFb != null) {
      await _aStorage(uFb);
      _usuarioCache = uFb;
      _fechaCache = DateTime.now();
    }
    return uFb;
  }

  bool _cacheOk() => _fechaCache != null && DateTime.now().difference(_fechaCache!) < _expira;

  Future<void> _aStorage(Usuario u) async {
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_kUser, jsonEncode(u.toMap()));
      await p.setString(_kFecha, DateTime.now().toIso8601String());
    } catch (_) {}
  }

  Future<Usuario?> _deStorage() async {
    try {
      final p = await SharedPreferences.getInstance();
      final j = p.getString(_kUser), f = p.getString(_kFecha);
      if (j == null || f == null) return null;
      _fechaCache = DateTime.parse(f);
      return Usuario.fromMap(jsonDecode(j));
    } catch (_) { return null; }
  }

  Future<void> _limpiarCache() async {
    _usuarioCache = null; _fechaCache = null;
    try {
      final p = await SharedPreferences.getInstance();
      await p.remove(_kUser); await p.remove(_kFecha);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Configuración', actions: [
      IconButton(icon: const Icon(Icons.refresh), onPressed: _recargar, tooltip: 'Recargar'),
    ]),
    backgroundColor: AppCSS.bgLight,
    body: _loadUser ? const Load(msg: 'Cargando perfil...')
        : _user == null ? const Vacio(msg: 'Error cargando usuario', ico: Icons.error)
        : SingleChildScrollView(
            padding: AppCSS.padM,
            child: Column(children: [
              AppCSS.gapM,
              _fotoPerfil(),
              _userSimple(),
              _tarjetaInfo(),
              _cambiarFoto(),
              _btnCerrar(),
              _infoApp(),
              AppCSS.gapM,
            ]),
          ),
  );

  // 📷 Foto perfil
  Widget _fotoPerfil() => Center(child: Container(
    width: 120, height: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle, color: AppCSS.white,
      boxShadow: [BoxShadow(color: AppCSS.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
    ),
    child: ClipOval(
      child: _user?.foto?.isNotEmpty == true
          ? Image.network(_user!.foto!, width: 120, height: 120, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _fotoDefault())
          : _fotoDefault(),
    ),
  ));

  Widget _fotoDefault() => Container(
    width: 120, height: 120,
    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppCSS.bgSoft),
    child: ClipOval(child: Image.asset(AppCSS.logoSmile, width: 120, height: 120, fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.account_circle, size: 80, color: AppCSS.primary),
    )),
  );

  Widget _userSimple() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppCSS.sp16),
    child: Text('@${_user?.usuario ?? 'Usuario'}', style: AppStyle.h3.copyWith(color: AppCSS.primary, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
  );

  // 📋 Tarjeta info
  Widget _tarjetaInfo() => Glass(child: Column(children: [
    _itemInfo('Nombres Completos', '${_user?.nombre ?? 'N/A'} ${_user?.apellidos ?? ''}', Icons.badge),
    Divider(color: AppCSS.grayLight, height: AppCSS.sp24),
    _itemInfo('Email', _user?.email ?? 'N/A', Icons.email),
    Divider(color: AppCSS.grayLight, height: AppCSS.sp24),
    _itemInfo('Grupo Unido', _user?.grupo ?? 'N/A', Icons.group),
  ]));

  Widget _itemInfo(String t, String v, IconData i) => Row(children: [
    Container(width: 45, height: 45, decoration: const BoxDecoration(color: AppCSS.bgSoft, shape: BoxShape.circle),
      child: Icon(i, color: AppCSS.primary, size: 22)),
    AppCSS.gapHS,
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(t, style: AppStyle.sm.copyWith(color: AppCSS.gray, fontWeight: FontWeight.w500)),
      Text(v, style: AppStyle.bd.copyWith(color: AppCSS.text700, fontWeight: FontWeight.w600)),
    ])),
  ]);

  // 🖼️ Cambiar foto
  Widget _cambiarFoto() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppCSS.sp16),
    child: Glass(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 45, height: 45, decoration: const BoxDecoration(color: AppCSS.bgSoft, shape: BoxShape.circle),
          child: const Icon(Icons.photo_camera, color: AppCSS.primary, size: 22)),
        AppCSS.gapHS,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Foto de Perfil', style: AppStyle.h3.copyWith(color: AppCSS.text700)),
          Text('Agrega el enlace de tu foto', style: AppStyle.sm.copyWith(color: AppCSS.gray)),
        ])),
      ]),
      AppCSS.gapM,
      Campo(lbl: 'URL de la imagen', hint: 'https://ejemplo.com/mi-foto.jpg', ico: Icons.link, ctrl: _ctrlFoto, kb: TextInputType.url),
      AppCSS.gapM,
      SizedBox(width: double.infinity, child: Btn(txt: _load ? 'Actualizando...' : 'Actualizar Foto', ico: Icons.update, load: _load, onTap: _actualizarFoto)),
    ])),
  );

  Widget _btnCerrar() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppCSS.sp8),
    child: SizedBox(width: double.infinity, child: ElevatedButton.icon(
      onPressed: _cerrarSesion,
      icon: const Icon(Icons.logout),
      label: const Text('Cerrar Sesión'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppCSS.error, foregroundColor: AppCSS.white,
        padding: const EdgeInsets.symmetric(vertical: AppCSS.sp16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppCSS.rad12)),
      ),
    )),
  );

  Widget _infoApp() => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppCSS.sp16),
    child: Column(children: [
      Text('Versión ${wii.version}', style: AppStyle.sm.copyWith(color: AppCSS.gray)),
      AppCSS.gapS,
      Text('Creado por Wii', style: AppStyle.sm.copyWith(color: AppCSS.gray, fontStyle: FontStyle.italic)),
    ]),
  );

  // 🔄 Acciones
  void _recargar() async {
    setState(() => _loadUser = true);
    try {
      if (!AuthServicio.estaLogueado) return;
      _usuarioCache = null; _fechaCache = null;
      final u = await DatabaseServicio.obtenerUsuarioPorEmail(AuthServicio.usuarioActual!.email!);
      if (u != null && mounted) {
        await _aStorage(u);
        _usuarioCache = u; _fechaCache = DateTime.now();
        setState(() => _user = u);
        Notificacion.ok(context, 'Datos actualizados 🔄');
      }
    } catch (e) {
      if (mounted) Notificacion.err(context, 'Error: $e');
    } finally {
      if (mounted) setState(() => _loadUser = false);
    }
  }

  void _actualizarFoto() async {
    final url = _ctrlFoto.text.trim();
    if (url.isEmpty) { Notificacion.err(context, 'Ingresa un enlace válido'); return; }
    setState(() => _load = true);
    try {
      if (_user != null) {
        await DatabaseServicio.actualizarFotoPerfil(_user!.usuario, url);
        final nuevo = Usuario(
          email: _user!.email, usuario: _user!.usuario, nombre: _user!.nombre,
          apellidos: _user!.apellidos, grupo: _user!.grupo, genero: _user!.genero,
          rol: _user!.rol, activo: _user!.activo, creacion: _user!.creacion,
          uid: _user!.uid, ultimaActividad: _user!.ultimaActividad,
          aceptoTerminos: _user!.aceptoTerminos, foto: url,
        );
        await _aStorage(nuevo);
        _usuarioCache = nuevo; _fechaCache = DateTime.now();
        setState(() => _user = nuevo);
        _ctrlFoto.clear();
        Notificacion.ok(context, '¡Foto actualizada! 📷');
      }
    } catch (e) {
      Notificacion.err(context, 'Error: $e');
    } finally {
      if (mounted) setState(() => _load = false);
    }
  }

  void _cerrarSesion() async {
    final ok = await Mensaje(context, titulo: 'Cerrar Sesión', msg: '¿Estás seguro que quieres cerrar sesión?');
    if (ok == true) {
      try {
        await _limpiarCache();
        await AuthServicio.logout();
        if (mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const PantallaLogin()), (r) => false);
      } catch (e) {
        if (mounted) Notificacion.err(context, 'Error: $e');
      }
    }
  }

  @override
  void dispose() { _ctrlFoto.dispose(); super.dispose(); }
}
