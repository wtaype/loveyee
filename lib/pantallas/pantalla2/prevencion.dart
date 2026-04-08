import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaPrevencion extends StatelessWidget {
  const PantallaPrevencion({super.key});

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Prevención'),
    backgroundColor: AppCSS.bgLight,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppCSS.sp16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 🛡️ CONSEJOS DIARIOS
        _buildSeccionHeader('Consejos Diarios de Prevención', 'Incorpora estos hábitos en tu rutina diaria', Icons.shield_outlined),
        AppCSS.gapM,
        ..._consejosDiarios.map((c) => _buildConsejoCard(c)),
        AppCSS.gapL,
        
        // ⏰ REGLA 20-20-20
        _buildRegla202020(),
        AppCSS.gapL,
        
        // 🍎 ALIMENTOS SALUDABLES
        _buildSeccionHeader('Alimentos que Aman tus Ojos', 'Una dieta balanceada mejora tu salud visual', Icons.apple_outlined),
        AppCSS.gapM,
        _buildAlimentosGrid(),
        AppCSS.gapL,
        
        // ⚠️ HÁBITOS NOCIVOS
        _buildSeccionHeader('Hábitos Nocivos a Evitar', 'Comportamientos que dañan tu visión', Icons.warning_amber),
        AppCSS.gapM,
        ..._habitosNocivos.map((h) => _buildHabitoCard(h)),
        AppCSS.gapM,
      ]),
    ),
  );

  // 📋 HEADER SECCIÓN
  Widget _buildSeccionHeader(String titulo, String desc, IconData ico) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(ico, color: AppCSS.primary, size: 28),
      AppCSS.gapHS,
      Flexible(child: Text(titulo, style: AppStyle.h3, textAlign: TextAlign.center)),
    ]),
    AppCSS.gapS,
    Text(desc, style: AppStyle.sm, textAlign: TextAlign.center),
    AppCSS.gapS,
    Container(width: 60, height: 4, decoration: BoxDecoration(
      gradient: AppCSS.gradGreen,
      borderRadius: BorderRadius.circular(2),
    )),
  ]);

  // 🛡️ CONSEJO CARD
  Widget _buildConsejoCard(_Consejo c) => Container(
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
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(c.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700)),
          Text(c.desc, style: AppStyle.sm.copyWith(color: AppCSS.text300)),
        ])),
      ]),
      AppCSS.gapM,
      ...c.tips.map((tip) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.check_circle, color: AppCSS.success, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(tip, style: AppStyle.sm)),
        ]),
      )),
    ]),
  );

  // ⏰ REGLA 20-20-20
  Widget _buildRegla202020() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: AppCSS.gradGreen,
      borderRadius: BorderRadius.circular(AppCSS.rad16),
      boxShadow: AppCSS.shadow,
    ),
    child: Column(children: [
      Text('⏰ La Regla de Oro: 20-20-20', style: AppStyle.h3.copyWith(color: AppCSS.white), textAlign: TextAlign.center),
      AppCSS.gapS,
      Text(
        'Si trabajas frente a una pantalla, esta regla simple puede salvar tus ojos de la fatiga visual digital.',
        style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.95)),
        textAlign: TextAlign.center,
      ),
      AppCSS.gapL,
      Row(children: [
        _buildReglaItem('20', 'Minutos', 'Cada 20 minutos frente a la pantalla'),
        AppCSS.gapHS,
        _buildReglaItem('20', 'Segundos', 'Descansa tu vista 20 segundos'),
        AppCSS.gapHS,
        _buildReglaItem('20', 'Pies (6m)', 'Mira algo a 20 pies de distancia'),
      ]),
    ]),
  );

  Widget _buildReglaItem(String num, String label, String desc) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppCSS.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppCSS.rad12),
        border: Border.all(color: AppCSS.white.withValues(alpha: 0.2)),
      ),
      child: Column(children: [
        Text(num, style: AppStyle.h1.copyWith(color: AppCSS.white, fontSize: 40)),
        Text(label, style: AppStyle.bdS.copyWith(color: AppCSS.white, fontWeight: FontWeight.w700)),
        AppCSS.gapS,
        Text(desc, style: AppStyle.sm.copyWith(color: AppCSS.white.withValues(alpha: 0.9)), textAlign: TextAlign.center, maxLines: 3),
      ]),
    ),
  );

  // 🍎 ALIMENTOS GRID
  Widget _buildAlimentosGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
    ),
    itemCount: _alimentos.length,
    itemBuilder: (c, i) {
      final a = _alimentos[i];
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppCSS.white,
          borderRadius: BorderRadius.circular(AppCSS.rad12),
          border: Border.all(color: AppCSS.border),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(a.emoji, style: const TextStyle(fontSize: 40)),
          AppCSS.gapS,
          Text(a.nombre, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(a.beneficio, style: AppStyle.sm, textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
        ]),
      );
    },
  );

  // ⚠️ HÁBITO NOCIVO CARD
  Widget _buildHabitoCard(_Habito h) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppCSS.white,
      borderRadius: BorderRadius.circular(AppCSS.rad12),
      border: const Border(left: BorderSide(color: AppCSS.error, width: 4)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          width: 45, height: 45,
          decoration: BoxDecoration(
            color: AppCSS.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppCSS.rad8),
          ),
          child: Icon(h.icon, color: AppCSS.error, size: 22),
        ),
        AppCSS.gapHM,
        Expanded(child: Text(h.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700))),
      ]),
      AppCSS.gapS,
      Text(h.desc, style: AppStyle.sm.copyWith(color: AppCSS.text300)),
    ]),
  );
}

// 📊 MODELOS DE DATOS
class _Consejo {
  final String titulo, desc;
  final List<String> tips;
  final IconData icon;
  final Color color;
  const _Consejo(this.titulo, this.desc, this.tips, this.icon, this.color);
}

class _Alimento {
  final String emoji, nombre, beneficio;
  const _Alimento(this.emoji, this.nombre, this.beneficio);
}

class _Habito {
  final String titulo, desc;
  final IconData icon;
  const _Habito(this.titulo, this.desc, this.icon);
}

// 🛡️ CONSEJOS DIARIOS
const _consejosDiarios = [
  _Consejo(
    'Protección Solar',
    'Los rayos UV pueden dañar tus ojos permanentemente.',
    ['Usa lentes con protección UV 100%', 'Usa sombrero en días soleados', 'Evita exposición directa al sol'],
    Icons.wb_sunny_outlined,
    AppCSS.warning,
  ),
  _Consejo(
    'Descanso Digital',
    'El uso excesivo de pantallas causa fatiga visual.',
    ['Aplica la regla 20-20-20', 'Ajusta el brillo de tu pantalla', 'Mantén distancia de 50-60 cm'],
    Icons.computer_outlined,
    AppCSS.info,
  ),
  _Consejo(
    'Hidratación Ocular',
    'Mantén tus ojos lubricados y saludables.',
    ['Parpadea frecuentemente', 'Usa lágrimas artificiales si es necesario', 'Bebe suficiente agua diariamente'],
    Icons.water_drop_outlined,
    AppCSS.bg6,
  ),
  _Consejo(
    'Descanso Adecuado',
    'Tus ojos necesitan recuperarse durante el sueño.',
    ['Duerme 7-8 horas diarias', 'Evita pantallas antes de dormir', 'Mantén tu habitación oscura'],
    Icons.bed_outlined,
    AppCSS.bg3,
  ),
  _Consejo(
    'Higiene Visual',
    'La limpieza previene infecciones oculares.',
    ['Lávate las manos antes de tocar tus ojos', 'No compartas toallas o maquillaje', 'Limpia tus lentes regularmente'],
    Icons.clean_hands_outlined,
    AppCSS.success,
  ),
  _Consejo(
    'Revisiones Periódicas',
    'La detección temprana salva tu visión.',
    ['Visita al oftalmólogo anualmente', 'Realiza exámenes completos', 'No ignores síntomas inusuales'],
    Icons.medical_services_outlined,
    AppCSS.primary,
  ),
];

// 🍎 ALIMENTOS SALUDABLES
const _alimentos = [
  _Alimento('🥕', 'Zanahorias', 'Ricas en vitamina A y betacaroteno para la visión nocturna'),
  _Alimento('🥬', 'Vegetales Verdes', 'Luteína y zeaxantina protegen contra la degeneración macular'),
  _Alimento('🐟', 'Pescado', 'Omega-3 previene el ojo seco y mejora la salud retinal'),
  _Alimento('🥚', 'Huevos', 'Zinc y antioxidantes esenciales para la salud ocular'),
  _Alimento('🍊', 'Cítricos', 'Vitamina C protege contra cataratas y degeneración'),
  _Alimento('🌰', 'Frutos Secos', 'Vitamina E y ácidos grasos protegen las células oculares'),
];

// ⚠️ HÁBITOS NOCIVOS
const _habitosNocivos = [
  _Habito(
    'Fumar',
    'El tabaco aumenta el riesgo de cataratas, degeneración macular y daño al nervio óptico. Dejar de fumar es una de las mejores decisiones para tu salud visual.',
    Icons.smoking_rooms_outlined,
  ),
  _Habito(
    'Frotarse los Ojos',
    'Frotar tus ojos con fuerza puede causar infecciones, rasguños en la córnea y empeorar condiciones como el queratocono. Si sientes picazón, usa lágrimas artificiales.',
    Icons.remove_red_eye_outlined,
  ),
  _Habito(
    'Dormir con Lentes de Contacto',
    'Dormir con lentes de contacto reduce el oxígeno a la córnea y aumenta el riesgo de infecciones graves. Siempre retíralos antes de dormir.',
    Icons.nightlight_outlined,
  ),
  _Habito(
    'Uso Excesivo de Pantallas',
    'Pasar muchas horas frente a pantallas sin descanso causa fatiga visual digital, ojos secos y dolores de cabeza. Aplica la regla 20-20-20.',
    Icons.phone_android_outlined,
  ),
  _Habito(
    'Mala Iluminación',
    'Leer o trabajar con poca luz fuerza tus ojos innecesariamente. Asegúrate de tener iluminación adecuada en tu espacio de trabajo.',
    Icons.lightbulb_outline,
  ),
  _Habito(
    'Ignorar Síntomas',
    'Posponer la visita al oftalmólogo cuando notas cambios en tu visión puede empeorar problemas tratables. Actúa rápido ante cualquier síntoma.',
    Icons.event_busy_outlined,
  ),
];