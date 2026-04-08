import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';

class PantallaAlimentos extends StatelessWidget {
  const PantallaAlimentos({super.key});

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: wiAppBar('Alimentos'),
    backgroundColor: AppCSS.bgLight,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppCSS.sp16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 🍎 SUPERALIMENTOS
        _buildSeccionHeader('Superalimentos para tu Visión', 'Nutrientes esenciales para tus ojos', Icons.local_dining_outlined),
        AppCSS.gapM,
        ..._superalimentos.map((a) => _buildAlimentoCard(a)),
        AppCSS.gapL,
        
        // 📊 NIVELES DE APORTE
        _buildSeccionHeader('Cómo Preparar tus Alimentos', 'La preparación afecta los nutrientes', Icons.restaurant_outlined),
        AppCSS.gapM,
        ..._preparaciones.map((p) => _buildPreparacionCard(p)),
        AppCSS.gapL,
        
        // 📅 PLAN SEMANAL
        _buildSeccionHeader('Plan Semanal Sugerido', 'Menú balanceado para toda la semana', Icons.calendar_today_outlined),
        AppCSS.gapM,
        ..._planSemanal.map((d) => _buildDiaCard(d)),
        AppCSS.gapM,
      ]),
    ),
  );

  // 📋 HEADER SECCIÓN
  Widget _buildSeccionHeader(String titulo, String desc, IconData ico) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(ico, color: AppCSS.warning, size: 28),
      AppCSS.gapHS,
      Flexible(child: Text(titulo, style: AppStyle.h3, textAlign: TextAlign.center)),
    ]),
    AppCSS.gapS,
    Text(desc, style: AppStyle.sm, textAlign: TextAlign.center),
    AppCSS.gapS,
    Container(width: 60, height: 4, decoration: BoxDecoration(
      gradient: LinearGradient(colors: [AppCSS.warning, AppCSS.bg5]),
      borderRadius: BorderRadius.circular(2),
    )),
  ]);

  // 🍎 ALIMENTO CARD
  Widget _buildAlimentoCard(_Alimento a) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: AppCSS.glass500,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            color: AppCSS.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppCSS.rad12),
          ),
          child: Center(child: Text(a.emoji, style: const TextStyle(fontSize: 32))),
        ),
        AppCSS.gapHM,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(a.titulo, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700)),
          Text(a.desc, style: AppStyle.sm.copyWith(color: AppCSS.text300), maxLines: 2),
        ])),
      ]),
      AppCSS.gapM,
      ...a.nutrientes.map((n) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.fiber_manual_record, color: AppCSS.warning, size: 10),
          const SizedBox(width: 8),
          Expanded(child: Text(n, style: AppStyle.sm)),
        ]),
      )),
    ]),
  );

  // 🔧 PREPARACIÓN CARD
  Widget _buildPreparacionCard(_Preparacion p) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppCSS.white,
      borderRadius: BorderRadius.circular(AppCSS.rad12),
      border: Border.all(color: AppCSS.border),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(p.emoji, style: const TextStyle(fontSize: 28)),
        AppCSS.gapHS,
        Expanded(child: Text(p.alimento, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700))),
      ]),
      AppCSS.gapM,
      ...p.metodos.map((m) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: m.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppCSS.rad8),
          border: Border.all(color: m.color.withValues(alpha: 0.3)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(m.nombre, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: m.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('${m.nivel}%', style: AppStyle.sm.copyWith(color: AppCSS.white, fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 4),
          Text(m.desc, style: AppStyle.sm),
        ]),
      )),
    ]),
  );

  // 📅 DÍA CARD
  Widget _buildDiaCard(_Dia d) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: AppCSS.glass500,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(d.emoji, style: const TextStyle(fontSize: 28)),
        AppCSS.gapHS,
        Text(d.dia, style: AppStyle.h3.copyWith(fontSize: 18, color: AppCSS.primary)),
      ]),
      AppCSS.gapM,
      ...d.comidas.map((c) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.restaurant, color: AppCSS.warning, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(c, style: AppStyle.sm)),
        ]),
      )),
    ]),
  );
}

// 📊 MODELOS DE DATOS
class _Alimento {
  final String emoji, titulo, desc;
  final List<String> nutrientes;
  const _Alimento(this.emoji, this.titulo, this.desc, this.nutrientes);
}

class _Preparacion {
  final String emoji, alimento;
  final List<_Metodo> metodos;
  const _Preparacion(this.emoji, this.alimento, this.metodos);
}

class _Metodo {
  final String nombre, desc;
  final int nivel;
  final Color color;
  const _Metodo(this.nombre, this.desc, this.nivel, this.color);
}

class _Dia {
  final String emoji, dia;
  final List<String> comidas;
  const _Dia(this.emoji, this.dia, this.comidas);
}

// 🍎 SUPERALIMENTOS
const _superalimentos = [
  _Alimento(
    '🥕', 'Zanahorias',
    'El superalimento clásico para los ojos. Rico en betacaroteno.',
    [
      'Vitamina A (betacaroteno) - Esencial para visión nocturna',
      'Luteína - Protege la retina',
      'Fibra - Mejora absorción de nutrientes',
      'Antioxidantes - Previenen degeneración macular',
    ],
  ),
  _Alimento(
    '🥬', 'Vegetales de Hoja Verde',
    'Espinaca, kale, col rizada. Ricos en luteína y zeaxantina.',
    [
      'Luteína y Zeaxantina - Filtran luz azul dañina',
      'Vitamina C - Antioxidante poderoso',
      'Vitamina E - Protege células oculares',
      'Hierro - Mejora oxigenación ocular',
    ],
  ),
  _Alimento(
    '🐟', 'Pescado Graso',
    'Salmón, atún, sardinas. Omega-3 DHA concentrado en la retina.',
    [
      'Omega-3 (DHA y EPA) - Salud retinal',
      'Vitamina D - Reduce inflamación',
      'Proteína de alta calidad',
      'Previene degeneración macular y ojo seco',
    ],
  ),
  _Alimento(
    '🥚', 'Huevos',
    'Fuente completa de nutrientes oculares. Luteína biodisponible.',
    [
      'Luteína y Zeaxantina - Fácilmente absorbibles',
      'Zinc - Transporta vitamina A a la retina',
      'Vitamina A - Previene ceguera nocturna',
      'Proteína completa - Reparación celular',
    ],
  ),
  _Alimento(
    '🍊', 'Cítricos',
    'Naranjas, limones, toronjas. Vitamina C protege tus ojos.',
    [
      'Vitamina C - Antioxidante potente',
      'Flavonoides - Mejoran circulación ocular',
      'Previenen cataratas',
      'Fortalecen vasos sanguíneos del ojo',
    ],
  ),
  _Alimento(
    '🌰', 'Frutos Secos y Semillas',
    'Almendras, nueces, chía, linaza. Vitamina E y omega-3.',
    [
      'Vitamina E - Protege membranas celulares',
      'Omega-3 vegetal (ALA)',
      'Zinc - Salud retinal',
      'Previenen degeneración relacionada con edad',
    ],
  ),
  _Alimento(
    '🫐', 'Arándanos',
    'Antocianinas mejoran visión nocturna y circulación retinal.',
    [
      'Antocianinas - Mejoran visión nocturna',
      'Vitamina C - Antioxidante',
      'Mejoran circulación retinal',
      'Reducen fatiga visual',
    ],
  ),
  _Alimento(
    '🍠', 'Camote (Batata)',
    'Altísimo en betacaroteno. Una porción cubre 400% de vitamina A.',
    [
      'Betacaroteno - Precursor de vitamina A',
      'Vitamina C - Antioxidante',
      'Fibra - Salud digestiva',
      'Previene ceguera nocturna',
    ],
  ),
];

// 🔧 PREPARACIONES
const _preparaciones = [
  _Preparacion(
    '🥕', 'Zanahoria',
    [
      _Metodo('Cocida al Vapor', 'Aumenta absorción de betacaroteno hasta 14%', 90, AppCSS.success),
      _Metodo('Cruda', 'Excelente fibra. Masticar bien', 85, AppCSS.success),
      _Metodo('Jugo con Agua Caliente', 'El calor destruye 30-40% de vitamina C', 60, AppCSS.warning),
    ],
  ),
  _Preparacion(
    '🐟', 'Pescado Graso',
    [
      _Metodo('Al Vapor', 'Preserva casi 100% de omega-3', 98, AppCSS.success),
      _Metodo('Al Horno (180°C)', 'Preserva 95% de omega-3', 95, AppCSS.success),
      _Metodo('A la Parrilla', 'Pierde 10-15% de omega-3', 85, AppCSS.info),
      _Metodo('Frito', 'Destruye 40-50% de omega-3. EVITAR', 50, AppCSS.error),
    ],
  ),
  _Preparacion(
    '🥬', 'Espinaca',
    [
      _Metodo('Salteada (2-3 min)', 'Aumenta biodisponibilidad de luteína 11%', 95, AppCSS.success),
      _Metodo('En Smoothie', 'Excelente absorción. Consumir inmediatamente', 90, AppCSS.success),
      _Metodo('Cruda', 'Máxima vitamina C. Agregar aceite', 85, AppCSS.success),
      _Metodo('Hervida (5+ min)', 'Pierde 50% de vitamina C. No recomendado', 60, AppCSS.warning),
    ],
  ),
];

// 📅 PLAN SEMANAL
const _planSemanal = [
  _Dia('🌅', 'Lunes', [
    'Desayuno: Omelette con espinaca + naranja',
    'Almuerzo: Salmón al horno + ensalada verde',
    'Cena: Sopa de zanahoria + pan integral',
  ]),
  _Dia('🌤️', 'Martes', [
    'Desayuno: Yogurt con arándanos y almendras',
    'Almuerzo: Pollo con camote asado + brócoli',
    'Cena: Ensalada de atún con pimientos',
  ]),
  _Dia('☀️', 'Miércoles', [
    'Desayuno: Smoothie verde (espinaca, plátano, chía)',
    'Almuerzo: Pescado con vegetales al vapor',
    'Cena: Tortilla de huevo con aguacate',
  ]),
  _Dia('🌈', 'Jueves', [
    'Desayuno: Avena con nueces y arándanos',
    'Almuerzo: Ensalada de kale con salmón',
    'Cena: Crema de zanahoria + huevo duro',
  ]),
  _Dia('🎉', 'Viernes', [
    'Desayuno: Tostada integral con aguacate + huevo',
    'Almuerzo: Atún con ensalada de col',
    'Cena: Camote relleno con vegetales',
  ]),
  _Dia('🌻', 'Sábado', [
    'Desayuno: Pancakes de camote + arándanos',
    'Almuerzo: Salmón con quinoa y espinaca',
    'Cena: Sopa de vegetales verdes',
  ]),
  _Dia('🌙', 'Domingo', [
    'Desayuno: Huevos revueltos + jugo de naranja',
    'Almuerzo: Pollo con ensalada arcoíris',
    'Cena: Smoothie de arándanos + almendras',
  ]),
];