import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaTratamiento extends StatelessWidget {
  const PantallaTratamiento({super.key});

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Tratamiento'),
    backgroundColor: AppCSS.bgLight,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppCSS.sp16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ⚠️ AVISO MÉDICO
        _buildAvisoMedico(),
        AppCSS.gapL,
        
        // 💊 CONDICIONES COMUNES
        _buildSeccionHeader('Condiciones Comunes', 'Conoce síntomas y tratamientos', Icons.healing_outlined),
        AppCSS.gapM,
        ..._condiciones.map((c) => _buildCondicionCard(c)),
        AppCSS.gapL,
        
        // 🏠 REMEDIOS CASEROS
        _buildSeccionHeader('Remedios Caseros Seguros', 'Complementa tu tratamiento médico', Icons.home_outlined),
        AppCSS.gapM,
        _buildRemediosGrid(),
        AppCSS.gapL,
        
        // 🚨 CUÁNDO ACUDIR AL MÉDICO
        _buildCuandoAcudir(),
        AppCSS.gapM,
      ]),
    ),
  );

  // ⚠️ AVISO MÉDICO
  Widget _buildAvisoMedico() => Container(
    padding: AppCSS.padL,
    decoration: BoxDecoration(
      gradient: AppCSS.gradGreen,
      borderRadius: BorderRadius.circular(AppCSS.rad20),
      boxShadow: AppCSS.shadow,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppCSS.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppCSS.rad12),
          ),
          child: const Icon(Icons.medical_information, color: AppCSS.white, size: 32),
        ),
        AppCSS.gapHM,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Información Importante 🩺', style: AppStyle.btn.copyWith(fontSize: 18)),
          AppCSS.gapS,
          Text('Consulta médica profesional', style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.9))),
        ])),
      ]),
      AppCSS.gapM,
      Text(
        'Esta información es educativa y no reemplaza la consulta médica profesional. Siempre consulta con un oftalmólogo para diagnóstico y tratamiento personalizado.',
        style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.95)),
      ),
      AppCSS.gapM,
      Row(children: [
        _buildInfoBadge(Icons.medical_services_outlined, 'Oftalmólogo'),
        AppCSS.gapHS,
        _buildInfoBadge(Icons.check_circle_outline, 'Diagnóstico'),
        AppCSS.gapHS,
        _buildInfoBadge(Icons.favorite_outline, 'Cuidado'),
      ]),
    ]),
  );

  Widget _buildInfoBadge(IconData ico, String lbl) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppCSS.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(ico, size: 14, color: AppCSS.white),
      const SizedBox(width: 4),
      Text(lbl, style: AppStyle.sm.copyWith(color: AppCSS.white, fontWeight: FontWeight.w600)),
    ]),
  );

  // 📋 HEADER SECCIÓN
  Widget _buildSeccionHeader(String titulo, String desc, IconData ico) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(ico, color: AppCSS.info, size: 28),
      AppCSS.gapHS,
      Flexible(child: Text(titulo, style: AppStyle.h3, textAlign: TextAlign.center)),
    ]),
    AppCSS.gapS,
    Text(desc, style: AppStyle.sm, textAlign: TextAlign.center),
    AppCSS.gapS,
    Container(width: 60, height: 4, decoration: BoxDecoration(
      gradient: LinearGradient(colors: [AppCSS.info, AppCSS.bg6]),
      borderRadius: BorderRadius.circular(2),
    )),
  ]);

  // 💊 CONDICIÓN CARD
  Widget _buildCondicionCard(_Condicion c) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: AppCSS.glass500,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            color: c.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppCSS.rad12),
          ),
          child: Icon(c.icon, color: c.color, size: 26),
        ),
        AppCSS.gapHM,
        Expanded(child: Text(c.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700))),
      ]),
      AppCSS.gapS,
      Text(c.desc, style: AppStyle.sm.copyWith(color: AppCSS.text300)),
      AppCSS.gapM,
      
      // Síntomas
      Row(children: [
        const Icon(Icons.warning_amber, color: AppCSS.warning, size: 18),
        const SizedBox(width: 6),
        Text('Síntomas:', style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600)),
      ]),
      AppCSS.gapS,
      ...c.sintomas.map((s) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.circle, size: 8, color: AppCSS.warning),
          const SizedBox(width: 8),
          Expanded(child: Text(s, style: AppStyle.sm)),
        ]),
      )),
      AppCSS.gapM,
      
      // Tratamiento
      Row(children: [
        const Icon(Icons.favorite, color: AppCSS.success, size: 18),
        const SizedBox(width: 6),
        Text('Tratamiento:', style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600)),
      ]),
      AppCSS.gapS,
      ...c.tratamiento.map((t) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.check_circle, size: 14, color: AppCSS.success),
          const SizedBox(width: 8),
          Expanded(child: Text(t, style: AppStyle.sm)),
        ]),
      )),
    ]),
  );

  // 🏠 REMEDIOS GRID
  Widget _buildRemediosGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.0,
    ),
    itemCount: _remedios.length,
    itemBuilder: (c, i) {
      final r = _remedios[i];
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppCSS.white,
          borderRadius: BorderRadius.circular(AppCSS.rad12),
          border: Border.all(color: AppCSS.border),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(r.emoji, style: const TextStyle(fontSize: 40)),
          AppCSS.gapS,
          Text(r.nombre, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(r.desc, style: AppStyle.sm, textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
        ]),
      );
    },
  );

  // 🚨 CUÁNDO ACUDIR
  Widget _buildCuandoAcudir() => Container(
    padding: AppCSS.padL,
    decoration: BoxDecoration(
      color: AppCSS.white,
      borderRadius: BorderRadius.circular(AppCSS.rad16),
      border: Border.all(color: AppCSS.error, width: 2),
    ),
    child: Column(children: [
      Row(children: [
        const Text('⚠️', style: TextStyle(fontSize: 32)),
        AppCSS.gapHS,
        Expanded(child: Text('¡IMPORTANTE! Cuándo Acudir al Oftalmólogo', style: AppStyle.h3.copyWith(color: AppCSS.error, fontSize: 16))),
      ]),
      AppCSS.gapM,
      Text('Algunos síntomas requieren atención médica inmediata. No esperes si experimentas:', style: AppStyle.bd),
      AppCSS.gapM,
      ..._senalesAlerta.map((s) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.error, color: AppCSS.error, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(s, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600))),
        ]),
      )),
      AppCSS.gapM,
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppCSS.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppCSS.rad8),
        ),
        child: Text(
          'Recuerda: La detección y tratamiento temprano pueden salvar tu visión. Ante la duda, siempre consulta con un profesional. 💙👁️',
          style: AppStyle.bd.copyWith(color: AppCSS.textGreen),
          textAlign: TextAlign.center,
        ),
      ),
    ]),
  );
}

// 📊 MODELOS DE DATOS
class _Condicion {
  final String titulo, desc;
  final List<String> sintomas, tratamiento;
  final IconData icon;
  final Color color;
  const _Condicion(this.titulo, this.desc, this.sintomas, this.tratamiento, this.icon, this.color);
}

class _Remedio {
  final String emoji, nombre, desc;
  const _Remedio(this.emoji, this.nombre, this.desc);
}

// 💊 CONDICIONES COMUNES
const _condiciones = [
  _Condicion(
    'Ojo Seco (Xeroftalmía)',
    'Los ojos no producen suficientes lágrimas, causando incomodidad.',
    ['Sensación de ardor o picazón', 'Enrojecimiento ocular', 'Sensibilidad a la luz', 'Visión borrosa intermitente'],
    ['Lágrimas artificiales sin conservantes (4-6 veces/día)', 'Geles lubricantes antes de dormir', 'Compresas tibias (10-15 min)', 'Aumentar consumo de Omega-3'],
    Icons.water_drop_outlined,
    AppCSS.bg6,
  ),
  _Condicion(
    'Orzuelo (Perrilla)',
    'Infección bacteriana formando un bulto doloroso en el párpado.',
    ['Bulto rojo y doloroso', 'Hinchazón del párpado', 'Sensibilidad al tacto', 'Lagrimeo excesivo'],
    ['Compresas tibias (10-15 min, 3-4 veces/día)', 'NO exprimir ni reventar', 'Limpieza suave con agua tibia', 'Evitar maquillaje hasta que sane'],
    Icons.warning_outlined,
    AppCSS.warning,
  ),
  _Condicion(
    'Conjuntivitis (Ojo Rojo)',
    'Inflamación muy contagiosa causada por virus, bacterias o alergias.',
    ['Enrojecimiento intenso', 'Secreción (clara/amarilla/verde)', 'Picazón o ardor', 'Párpados pegados al despertar'],
    ['Compresas frías para alivio', 'Lágrimas artificiales', 'Antibiótico si es bacteriana', 'Lavar manos frecuentemente'],
    Icons.remove_red_eye_outlined,
    AppCSS.error,
  ),
  _Condicion(
    'Fatiga Visual Digital',
    'Cansancio ocular por uso prolongado de pantallas.',
    ['Ojos cansados o pesados', 'Visión borrosa temporal', 'Dolor de cabeza', 'Ojos secos'],
    ['Regla 20-20-20', 'Ajustar brillo de pantalla', 'Usar filtro de luz azul', 'Parpadear conscientemente', 'Posicionar pantalla a 50-60 cm'],
    Icons.computer_outlined,
    AppCSS.success,
  ),
  _Condicion(
    'Blefaritis (Inflamación del Párpado)',
    'Inflamación crónica de los bordes de los párpados.',
    ['Párpados rojos e hinchados', 'Costras en las pestañas', 'Picazón en los párpados', 'Sensación de ardor'],
    ['Limpieza diaria con champú suave', 'Compresas tibias (2 veces/día)', 'Masaje suave de párpados', 'Evitar maquillaje durante tratamiento'],
    Icons.visibility_off_outlined,
    AppCSS.bg3,
  ),
];

// 🏠 REMEDIOS CASEROS
const _remedios = [
  _Remedio('🧊', 'Compresas Frías', 'Reduce inflamación y alivia ojos cansados'),
  _Remedio('♨️', 'Compresas Tibias', 'Ayuda con orzuelos y blefaritis'),
  _Remedio('💧', 'Lágrimas Artificiales', 'Lubrica y alivia ojos secos'),
  _Remedio('🥒', 'Rodajas de Pepino', 'Efecto refrescante y descongestivo'),
  _Remedio('🍵', 'Té Verde', 'Propiedades antiinflamatorias'),
  _Remedio('💤', 'Descanso Adecuado', 'Dormir 7-8 horas recupera tus ojos'),
];

// 🚨 SEÑALES DE ALERTA
const _senalesAlerta = [
  'Pérdida súbita de visión',
  'Dolor ocular intenso',
  'Destellos de luz o moscas volantes repentinas',
  'Trauma o lesión ocular',
  'Enrojecimiento con dolor y visión borrosa',
  'Síntomas que empeoran o no mejoran en 48 horas',
];