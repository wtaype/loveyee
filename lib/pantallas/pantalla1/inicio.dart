import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';
import '../../wii.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: AppCSS.bgLight,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppCSS.sp16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 👋 SALUDO
          _buildSaludo(),
          AppCSS.gapL,
          
          // 🦋 HERO CARD
          _buildHeroCard(),
          AppCSS.gapL,
          
          // 📊 ESTADÍSTICAS
          _buildStats(),
          AppCSS.gapL,
          
          // 🧭 NAVEGACIÓN
          Text('Explora', style: AppStyle.h3),
          AppCSS.gapS,
          _buildNavGrid(c),
          AppCSS.gapL,
          
          // 💡 TIP DEL DÍA
          _buildTipDelDia(),
          AppCSS.gapM,
        ]),
      ),
    ),
  );

  // 👋 SALUDO
  Widget _buildSaludo() => Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(Saludar(), style: AppStyle.bd.copyWith(color: AppCSS.text300)),
      Text('Bienvenido a ${wii.app}', style: AppStyle.h2),
    ])),
    AppCSS.logoCirculo(size: 50),
  ]);

  // 🦋 HERO CARD
  Widget _buildHeroCard() => Container(
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
          child: const Icon(Icons.visibility, color: AppCSS.white, size: 32),
        ),
        AppCSS.gapHM,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Amor por tus Ojitos 👁️💙', style: AppStyle.btn.copyWith(fontSize: 18)),
          AppCSS.gapS,
          Text('Tu visión es invaluable', style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.9))),
        ])),
      ]),
      AppCSS.gapM,
      Text(
        'Aquí encontrarás herramientas, información y esperanza para cuidar el regalo más precioso: tu visión.',
        style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.95)),
      ),
      AppCSS.gapM,
      Row(children: [
        _buildHeroBadge(Icons.shield_outlined, 'Prevención'),
        AppCSS.gapHS,
        _buildHeroBadge(Icons.restaurant_outlined, 'Nutrición'),
        AppCSS.gapHS,
        _buildHeroBadge(Icons.healing_outlined, 'Cuidado'),
      ]),
    ]),
  );

  Widget _buildHeroBadge(IconData ico, String lbl) => Container(
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

  // 📊 ESTADÍSTICAS
  Widget _buildStats() => Row(children: [
    _buildStatCard('2.2B+', 'Problemas visuales', Icons.people_outline, AppCSS.info),
    AppCSS.gapHS,
    _buildStatCard('80%', 'Prevenibles', Icons.verified_outlined, AppCSS.primary),
    AppCSS.gapHS,
    _buildStatCard('20-20', 'Regla visual', Icons.timer_outlined, AppCSS.warning),
  ]);

  Widget _buildStatCard(String val, String lbl, IconData ico, Color clr) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: AppCSS.glass500,
      child: Column(children: [
        Icon(ico, color: clr, size: 24),
        const SizedBox(height: 6),
        Text(val, style: AppStyle.h3.copyWith(color: clr, fontSize: 16)),
        Text(lbl, style: AppStyle.sm, textAlign: TextAlign.center),
      ]),
    ),
  );

  // 🧭 NAVEGACIÓN
  Widget _buildNavGrid(BuildContext c) => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 1.4,
    children: _navItems.map((item) => _buildNavCard(c, item)).toList(),
  );

  Widget _buildNavCard(BuildContext c, _NavItem item) => GestureDetector(
    onTap: () => _navegarA(c, item.page),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: AppCSS.glass500,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppCSS.rad8),
          ),
          child: Icon(item.icon, color: item.color, size: 22),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.title, style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600)),
          Text(item.desc, style: AppStyle.sm, maxLines: 1, overflow: TextOverflow.ellipsis),
        ]),
      ]),
    ),
  );

  void _navegarA(BuildContext c, int page) {
    // Navegar a la página usando el PageController del padre
    final state = c.findAncestorStateOfType<State>();
    if (state != null && state.mounted) {
      // Alternativa: usar callback o provider para cambiar página
    }
  }

  // 💡 TIP DEL DÍA
  Widget _buildTipDelDia() => Container(
    padding: AppCSS.padL,
    decoration: BoxDecoration(
      color: AppCSS.info.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppCSS.rad16),
      border: Border.all(color: AppCSS.info.withValues(alpha: 0.3)),
    ),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppCSS.info,
          borderRadius: BorderRadius.circular(AppCSS.rad8),
        ),
        child: const Icon(Icons.lightbulb_outline, color: AppCSS.white, size: 20),
      ),
      AppCSS.gapHM,
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('💡 Tip del día', style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w600, color: AppCSS.info)),
        const SizedBox(height: 4),
        Text(
          'Regla 20-20-20: Cada 20 minutos, mira algo a 20 pies (6m) por 20 segundos.',
          style: AppStyle.sm,
        ),
      ])),
    ]),
  );
}

// 🧭 Items de navegación
class _NavItem {
  final String title, desc;
  final IconData icon;
  final Color color;
  final int page;
  const _NavItem(this.title, this.desc, this.icon, this.color, this.page);
}

const _navItems = [
  _NavItem('Prevención', 'Tips para cuidar tus ojos', Icons.shield_outlined, AppCSS.primary, 1),
  _NavItem('Alimentos', 'Nutrición ocular', Icons.restaurant_outlined, AppCSS.warning, 2),
  _NavItem('Tratamiento', 'Opciones de cuidado', Icons.healing_outlined, AppCSS.info, 3),
  _NavItem('Acerca', 'Nuestra historia', Icons.favorite_outline, AppCSS.error, 4),
];
