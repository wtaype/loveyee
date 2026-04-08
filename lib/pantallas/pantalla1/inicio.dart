import 'package:flutter/material.dart';
import '../../wicss.dart';
import '../../widev.dart';
import '../../wii.dart';

class PantallaInicio extends StatelessWidget {
  final Function(int) onNavigate; // Callback para navegar
  
  const PantallaInicio({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: AppCSS.bgLight,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppCSS.sp16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 👋 SALUDO SIMPLE
          AppCSS.gapS,
          Text(Saludar(), style: AppStyle.bd.copyWith(color: AppCSS.text300)),
          Text('Bienvenido a ${wii.app}', style: AppStyle.h2),
          AppCSS.gapL,
          
          // 🦋 HERO CARD PRINCIPAL
          _buildHeroCard(),
          AppCSS.gapL,
          
          // 📊 STATS
          _buildStats(),
          AppCSS.gapL,
          
          // 🧭 NAVEGACIÓN
          Text('Explora', style: AppStyle.h3),
          AppCSS.gapM,
          _buildNavGrid(),
          AppCSS.gapL,
          
          // 💡 TIP DEL DÍA
          _buildTipDelDia(),
          AppCSS.gapM,
        ]),
      ),
    ),
  );

  // 🦋 HERO CARD PRINCIPAL
  Widget _buildHeroCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: AppCSS.gradGreen,
      borderRadius: BorderRadius.circular(AppCSS.rad20),
      boxShadow: AppCSS.shadow,
    ),
    child: Column(children: [
      // Logo circular
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppCSS.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
        ),
        child: ClipOval(child: AppCSS.logo),
      ),
      AppCSS.gapM,
      
      // Texto principal
      Text(
        'Amor por tus Ojitos 👁️💙',
        style: AppStyle.h2.copyWith(color: AppCSS.white, fontSize: 22),
        textAlign: TextAlign.center,
      ),
      AppCSS.gapS,
      Text(
        'Tu visión es invaluable. Cuídala con información confiable y amor.',
        style: AppStyle.bdS.copyWith(color: AppCSS.white.withValues(alpha: 0.95)),
        textAlign: TextAlign.center,
      ),
      AppCSS.gapL,
      
      // Badges
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          _buildBadge(Icons.shield_outlined, 'Prevención'),
          _buildBadge(Icons.restaurant_outlined, 'Nutrición'),
          _buildBadge(Icons.favorite_outline, 'Cuidado'),
        ],
      ),
    ]),
  );

  Widget _buildBadge(IconData ico, String lbl) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: AppCSS.white.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppCSS.white.withValues(alpha: 0.3)),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(ico, size: 16, color: AppCSS.white),
      const SizedBox(width: 6),
      Text(lbl, style: AppStyle.sm.copyWith(color: AppCSS.white, fontWeight: FontWeight.w600)),
    ]),
  );

  // 📊 STATS MEJORADOS
  Widget _buildStats() => Row(children: [
    _buildStatCard('2.2B', 'Problemas visuales', AppCSS.info),
    AppCSS.gapHS,
    _buildStatCard('80%', 'Prevenibles', AppCSS.success),
    AppCSS.gapHS,
    _buildStatCard('20-20-20', 'Regla visual', AppCSS.warning),
  ]);

  Widget _buildStatCard(String val, String lbl, Color clr) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppCSS.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppCSS.rad12),
        border: Border.all(color: clr.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Text(val, style: AppStyle.h3.copyWith(color: clr, fontSize: 18)),
        const SizedBox(height: 4),
        Text(lbl, style: AppStyle.sm.copyWith(fontSize: 11), textAlign: TextAlign.center, maxLines: 2),
      ]),
    ),
  );

  // 🧭 NAVEGACIÓN MEJORADA CON FUNCIONALIDAD
  Widget _buildNavGrid() => GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 1.3,
    children: _navItems.map((item) => _buildNavCard(item)).toList(),
  );

  Widget _buildNavCard(_NavItem item) => GestureDetector(
    onTap: () => onNavigate(item.page), // Usar el callback
    child: Container(
      decoration: BoxDecoration(
        color: AppCSS.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(AppCSS.rad16),
        border: Border.all(color: item.color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: item.color.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppCSS.rad12),
            ),
            child: Icon(item.icon, color: item.color, size: 28),
          ),
          AppCSS.gapS,
          Text(
            item.title,
            style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            item.desc,
            style: AppStyle.sm.copyWith(fontSize: 11, color: AppCSS.text300),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    ),
  );

  // 💡 TIP DEL DÍA MEJORADO
  Widget _buildTipDelDia() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppCSS.info.withValues(alpha: 0.08), AppCSS.bg6.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(AppCSS.rad16),
      border: Border.all(color: AppCSS.info.withValues(alpha: 0.2)),
    ),
    child: Row(children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppCSS.info,
          borderRadius: BorderRadius.circular(AppCSS.rad12),
          boxShadow: [BoxShadow(color: AppCSS.info.withValues(alpha: 0.3), blurRadius: 8)],
        ),
        child: const Icon(Icons.lightbulb, color: AppCSS.white, size: 24),
      ),
      AppCSS.gapHM,
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('💡 Tip del día', style: AppStyle.bdS.copyWith(fontWeight: FontWeight.w700, color: AppCSS.info)),
        const SizedBox(height: 4),
        Text(
          'Regla 20-20-20: Cada 20 minutos, mira algo a 20 pies (6m) por 20 segundos.',
          style: AppStyle.sm.copyWith(color: AppCSS.text500),
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
  final int page; // Índice de la página
  const _NavItem(this.title, this.desc, this.icon, this.color, this.page);
}

const _navItems = [
  _NavItem('Prevención', 'Tips diarios', Icons.shield_outlined, AppCSS.primary, 1),
  _NavItem('Alimentos', 'Nutrición', Icons.restaurant_outlined, AppCSS.warning, 2),
  _NavItem('Tratamiento', 'Cuidado', Icons.healing_outlined, AppCSS.info, 3),
  _NavItem('Acerca', 'Historia', Icons.favorite_outline, AppCSS.error, 4),
];
