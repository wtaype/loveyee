import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';
import '../../wii.dart';

class PantallaAcerca extends StatelessWidget {
  const PantallaAcerca({super.key});

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Acerca de ${wii.app}'),
    backgroundColor: AppCSS.bgLight,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppCSS.sp16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // 🦋 HERO CON LOGO
        _buildHero(),
        AppCSS.gapL,
        
        // 💡 CURIOSIDADES
        _buildSeccionHeader('Curiosidades Fascinantes', 'Datos increíbles sobre tus ojos', Icons.lightbulb_outline),
        AppCSS.gapM,
        _buildCuriosidadesGrid(),
        AppCSS.gapL,
        
        // ❤️ PROYECTO
        _buildSeccionHeader('Acerca del Proyecto', 'La historia detrás de ${wii.app}', Icons.favorite_outline),
        AppCSS.gapM,
        _buildProyecto(),
        AppCSS.gapL,
        
        // 🌟 MISIÓN
        ..._mision.map((m) => _buildMisionCard(m)),
        AppCSS.gapL,
        
        // ⭐ CONSEJOS FINALES
        _buildSeccionHeader('Consejos Finales', 'Puntos clave para tu visión', Icons.star_outline),
        AppCSS.gapM,
        ..._consejosFinales.map((c) => _buildConsejoFinalCard(c)),
        AppCSS.gapL,
        
        // 💙 MENSAJE FINAL
        _buildMensajeFinal(),
        AppCSS.gapM,
      ]),
    ),
  );

  // 🦋 HERO CON LOGO
  Widget _buildHero() => Column(children: [
    AppCSS.gapM,
    AppCSS.logoCirculo(size: 100),
    AppCSS.gapM,
    Text('👁️💙 ${wii.app}', style: AppStyle.h1.copyWith(fontSize: 32)),
    AppCSS.gapS,
    Text(
      'Un proyecto nacido del amor, la fe y el deseo de ayudar a otros a cuidar el regalo más preciado: la visión.',
      style: AppStyle.bd,
      textAlign: TextAlign.center,
    ),
    AppCSS.gapS,
    Text(
      'Porque tus ojitos merecen todo el amor del mundo. 💙',
      style: AppStyle.bdS.copyWith(color: AppCSS.primary, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
  ]);

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

  // 💡 CURIOSIDADES GRID
  Widget _buildCuriosidadesGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.0,
    ),
    itemCount: _curiosidades.length,
    itemBuilder: (c, i) {
      final cur = _curiosidades[i];
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppCSS.white,
          borderRadius: BorderRadius.circular(AppCSS.rad12),
          border: Border.all(color: AppCSS.border),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(cur.emoji, style: const TextStyle(fontSize: 36)),
          AppCSS.gapS,
          Text(cur.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Expanded(child: Text(cur.desc, style: AppStyle.sm, textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis)),
        ]),
      );
    },
  );

  // 📖 PROYECTO
  Widget _buildProyecto() => Container(
    padding: AppCSS.padL,
    decoration: AppCSS.glass500,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.book_outlined, color: AppCSS.primary, size: 24),
        AppCSS.gapHS,
        Text('Nuestra Historia', style: AppStyle.h3.copyWith(fontSize: 18)),
      ]),
      AppCSS.gapM,
      Text(
        '${wii.app} nació de una experiencia personal con problemas de visión. Cuando enfrenté desafíos con mis ojos, me di cuenta de cuánta información valiosa desconocía sobre el cuidado visual.',
        style: AppStyle.bd,
      ),
      AppCSS.gapS,
      Text(
        'Este proyecto es mi manera de transformar esa experiencia en algo positivo. Quiero que otras personas tengan acceso a la información que yo necesité: prevención, nutrición, ejercicios, tratamientos y esperanza.',
        style: AppStyle.bd,
      ),
      AppCSS.gapS,
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppCSS.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppCSS.rad8),
        ),
        child: Text(
          'Si esta información ayuda aunque sea a una persona a cuidar mejor sus ojos, habrá valido la pena. 🙏💙',
          style: AppStyle.bdS.copyWith(color: AppCSS.textGreen, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    ]),
  );

  // 🌟 MISIÓN CARD
  Widget _buildMisionCard(_Mision m) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppCSS.white,
      borderRadius: BorderRadius.circular(AppCSS.rad12),
      border: Border.all(color: m.color.withValues(alpha: 0.3)),
    ),
    child: Row(children: [
      Container(
        width: 50, height: 50,
        decoration: BoxDecoration(
          color: m.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppCSS.rad12),
        ),
        child: Center(child: Text(m.emoji, style: const TextStyle(fontSize: 28))),
      ),
      AppCSS.gapHM,
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(m.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(m.desc, style: AppStyle.sm),
      ])),
    ]),
  );

  // ⭐ CONSEJO FINAL CARD
  Widget _buildConsejoFinalCard(_ConsejoFinal c) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: AppCSS.glass500,
    child: Row(children: [
      Container(
        width: 45, height: 45,
        decoration: BoxDecoration(
          color: AppCSS.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppCSS.rad8),
        ),
        child: Icon(c.icon, color: AppCSS.primary, size: 22),
      ),
      AppCSS.gapHM,
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(c.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(c.desc, style: AppStyle.sm),
      ])),
    ]),
  );

  // 💙 MENSAJE FINAL
  Widget _buildMensajeFinal() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: AppCSS.gradGreen,
      borderRadius: BorderRadius.circular(AppCSS.rad16),
      boxShadow: AppCSS.shadow,
    ),
    child: Column(children: [
      Text('💙 Gracias por Visitar ${wii.app} 👁️', style: AppStyle.h3.copyWith(color: AppCSS.white), textAlign: TextAlign.center),
      AppCSS.gapM,
      Text(
        'Recuerda: Tus ojos son un regalo precioso. Cuídalos con amor, aliméntalos bien, descánsalos adecuadamente y visita a tu oftalmólogo regularmente.',
        style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.95)),
        textAlign: TextAlign.center,
      ),
      AppCSS.gapM,
      Text(
        '🙏 Con fe, todo es posible. Nunca pierdas la esperanza. 🙏',
        style: AppStyle.bdS.copyWith(color: AppCSS.white, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      AppCSS.gapM,
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppCSS.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppCSS.rad8),
        ),
        child: Text(
          'Hecho con 💙 por ${wii.by}\n${wii.version} © ${wii.lanzamiento}',
          style: AppStyle.sm.copyWith(color: AppCSS.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]),
  );
}

// 📊 MODELOS DE DATOS
class _Curiosidad {
  final String emoji, titulo, desc;
  const _Curiosidad(this.emoji, this.titulo, this.desc);
}

class _Mision {
  final String emoji, titulo, desc;
  final Color color;
  const _Mision(this.emoji, this.titulo, this.desc, this.color);
}

class _ConsejoFinal {
  final String titulo, desc;
  final IconData icon;
  const _ConsejoFinal(this.titulo, this.desc, this.icon);
}

// 💡 CURIOSIDADES
const _curiosidades = [
  _Curiosidad('⚡', 'Músculo Más Rápido', 'Puedes parpadear 5 veces por segundo. ¡28,800 veces al día!'),
  _Curiosidad('🎨', '10 Millones de Colores', 'El ojo humano puede distinguir 10 millones de colores'),
  _Curiosidad('🔍', 'Iris Único', 'Tu iris tiene 256 características únicas vs 40 de las huellas'),
  _Curiosidad('💧', 'Lágrimas Complejas', 'Las lágrimas tienen 3 capas: aceite, agua y mucosa'),
  _Curiosidad('🧠', 'Conexión Cerebral', '50% de la corteza cerebral procesa información visual'),
  _Curiosidad('🌈', 'Visión Nocturna', 'Puedes ver una vela a 1.6 km en completa oscuridad'),
];

// 🌟 MISIÓN
const _mision = [
  _Mision('💙', 'Amor por tus Ojitos', 'Compartir conocimiento para prevenir problemas visuales', AppCSS.primary),
  _Mision('📚', 'Educación Accesible', 'Información oftalmológica fácil de entender para todos', AppCSS.info),
  _Mision('🙏', 'Fe y Esperanza', 'Con Dios todo es posible. Nunca pierdas la fe', AppCSS.success),
];

// ⭐ CONSEJOS FINALES
const _consejosFinales = [
  _ConsejoFinal('Exámenes Regulares', 'Visita al oftalmólogo anualmente', Icons.calendar_today_outlined),
  _ConsejoFinal('Protección UV', 'Usa lentes de sol con UV 100%', Icons.wb_sunny_outlined),
  _ConsejoFinal('Descansos Digitales', 'Aplica la regla 20-20-20 religiosamente', Icons.computer_outlined),
  _ConsejoFinal('Nutrición Balanceada', 'Come vitaminas A, C, E y Omega-3 diariamente', Icons.restaurant_outlined),
  _ConsejoFinal('Sueño Reparador', 'Duerme 7-8 horas para que tus ojos se recuperen', Icons.bed_outlined),
  _ConsejoFinal('Escucha tu Cuerpo', 'No ignores síntomas. Consulta inmediatamente', Icons.favorite_outline),
];