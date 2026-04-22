import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/custom_cursor.dart';
import '../../../app/widgets/floating_blobs.dart';
import '../../../app/widgets/glass_panel.dart';
import '../../../app/widgets/neon_button.dart';
import '../viewmodel/home_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);

    return CustomCursor(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.surfaceDim,
                ),
                child: const SizedBox(),
              ),
            ),
            const Positioned.fill(child: FloatingBlobs()),
            Positioned.fill(
              child: SingleChildScrollView(
                controller: vm.scrollController,
                child: Column(
                  children: [
                    _HeroSection(key: vm.homeKey),
                    _SkillsSection(key: vm.skillsKey),
                    _ProjectsSection(key: vm.projectsKey),
                    _ContactSection(key: vm.contactKey),
                    const _Footer(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: _NavBar(
                onHome: () => vm.scrollTo(vm.homeKey),
                onSkills: () => vm.scrollTo(vm.skillsKey),
                onProjects: () => vm.scrollTo(vm.projectsKey),
                onContact: () => vm.scrollTo(vm.contactKey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.onHome,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  final VoidCallback onHome;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GlassPanel(
            borderRadius: BorderRadius.circular(999),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              children: [
                Text(
                  'Adil Ashfaq',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryFixed,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                ),
                const Spacer(),
                if (MediaQuery.sizeOf(context).width >= 840) ...[
                  _NavLink(label: 'Home', isActive: true, onTap: onHome),
                  const SizedBox(width: 28),
                  _NavLink(label: 'Skills', onTap: onSkills),
                  const SizedBox(width: 28),
                  _NavLink(label: 'Projects', onTap: onProjects),
                  const SizedBox(width: 28),
                  _NavLink(label: 'Contact', onTap: onContact),
                  const SizedBox(width: 28),
                ],
                _PillButton(label: 'Hire Me', onTap: onContact),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap, this.isActive = false});

  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primaryFixed : Colors.white.withValues(alpha: 0.55);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primaryFixed,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryFixed.withValues(alpha: 0.25),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.surfaceDim,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3,
                ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 132, 24, 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(flex: 3, child: _HeroCopy()),
                    SizedBox(width: 48),
                    Expanded(flex: 2, child: _HeroImage()),
                  ],
                )
              : const Column(
                  children: [
                    _HeroCopy(),
                    SizedBox(height: 48),
                    _HeroImage(),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassPanel(
          borderRadius: BorderRadius.circular(999),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          opacity: 0.35,
          child: Text(
            'Available for Freelance'.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryFixed,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  fontSize: 10,
                ),
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: MediaQuery.sizeOf(context).width >= 900 ? 86 : 56,
                  fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                ),
            children: [
              const TextSpan(text: 'I AM '),
              TextSpan(
                text: 'ADIL ASHFAQ',
                style: TextStyle(
                  color: AppColors.primaryFixed,
                  shadows: [
                    Shadow(
                      color: AppColors.primaryFixed.withValues(alpha: 0.30),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
              const TextSpan(text: ',\n'),
              TextSpan(
                text: 'FULL STACK.',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        AppColors.white,
                        Color(0xCCFFFFFF),
                        Color(0x66FFFFFF),
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 600, 120)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'BUILDING SOPHISTICATED EXPERIENCES, SPECIALIZING IN FLUTTER.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                fontWeight: FontWeight.w300,
                color: AppColors.onSurface.withValues(alpha: 0.85),
                height: 1.35,
              ),
        ),
        const SizedBox(height: 32),
        NeonButton(
          label: 'VIEW MY WORK',
          onPressed: () {
            // handled by navbar; keeping local CTA purely visual
          },
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: const LinearGradient(
                colors: [AppColors.primaryFixed, AppColors.secondary],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: GlassPanel(
            borderRadius: BorderRadius.circular(40),
            opacity: 0.35,
            borderOpacity: 0.05,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/hero.jpg',
                      fit: BoxFit.cover,
                      color: AppColors.white.withValues(alpha: 0.40),
                      colorBlendMode: BlendMode.luminosity,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.surfaceDim.withValues(alpha: 0.80),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'TECH TOOLKIT',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      fontSize: 54,
                    ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 128,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryFixed.withValues(alpha: 0.35),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 980;
                  return isWide
                      ? const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _TechChips()),
                            SizedBox(width: 48),
                            Expanded(child: _MethodologiesCard()),
                          ],
                        )
                      : const Column(
                          children: [
                            _TechChips(),
                            SizedBox(height: 32),
                            _MethodologiesCard(),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChips extends StatelessWidget {
  const _TechChips();

  @override
  Widget build(BuildContext context) {
    final chips = [
      'Dart',
      'Firebase',
      'Android Studio',
      'Xcode',
      'Git',
      'Figma',
      'Riverpod',
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        GlassPanel(
          borderRadius: BorderRadius.circular(18),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flutter_dash, color: AppColors.primaryFixed, size: 28, shadows: [
                Shadow(color: AppColors.primaryFixed.withValues(alpha: 0.30), blurRadius: 12),
              ]),
              const SizedBox(width: 12),
              Text(
                'Flutter',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
              ),
            ],
          ),
        ),
        ...chips.map(
          (c) => GlassPanel(
            borderRadius: BorderRadius.circular(14),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            opacity: 0.35,
            borderOpacity: 0.06,
            child: Text(
              c.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.onSurface.withValues(alpha: 0.70),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MethodologiesCard extends StatelessWidget {
  const _MethodologiesCard();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      borderRadius: BorderRadius.circular(48),
      padding: const EdgeInsets.all(32),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: AppColors.primaryFixed.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'METHODOLOGIES',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.primaryFixed,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      fontSize: 10,
                    ),
              ),
              const SizedBox(height: 24),
              const _MethodItem(
                title: 'MVVM Architecture',
                subtitle: 'Engineered for absolute scalability and clean logic isolation.',
              ),
              const SizedBox(height: 22),
              const _MethodItem(
                title: 'Unit Testing',
                subtitle: 'Bulletproof code with 90%+ coverage across business logic.',
              ),
              const SizedBox(height: 22),
              const _MethodItem(
                title: 'Agile Development',
                subtitle: 'Rapid delivery cycles with high-transparency communication.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MethodItem extends StatelessWidget {
  const _MethodItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.primaryFixed,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryFixed.withValues(alpha: 0.55),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w300,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = const [
      _ProjectCardData(
        title: 'ECO-TRACKER',
        subtitle: 'Sustainability dashboard for green living.',
        assetPath: 'assets/images/project_eco.jpg',
      ),
      _ProjectCardData(
        title: 'STREAMLINED CRM',
        subtitle: 'Business management at your fingertips.',
        assetPath: 'assets/images/project_crm.jpg',
      ),
      _ProjectCardData(
        title: 'FITNESS BUDDY',
        subtitle: 'AI-driven workout and nutrition tracker.',
        assetPath: 'assets/images/project_fitness.jpg',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 900;
                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PORTFOLIO SHOWCASE',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: AppColors.primaryFixed,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 3,
                                          fontSize: 10,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'FEATURED WORK',
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                          fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -1,
                                          fontSize: 54,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            SizedBox(
                              width: 360,
                              child: Text(
                                'High-performance mobile experiences crafted with precision and pixel-perfect attention.',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5,
                                    ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PORTFOLIO SHOWCASE',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.primaryFixed,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3,
                                    fontSize: 10,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'FEATURED WORK',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -1,
                                    fontSize: 54,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'High-performance mobile experiences crafted with precision and pixel-perfect attention.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                  ),
                            ),
                          ],
                        );
                },
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 960 ? 3 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: crossAxisCount == 1 ? 1.1 : 0.70,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, i) => _ProjectCard(data: cards[i]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCardData {
  const _ProjectCardData({required this.title, required this.subtitle, required this.assetPath});

  final String title;
  final String subtitle;
  final String assetPath;
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.data});

  final _ProjectCardData data;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  double _hover = 0;

  @override
  Widget build(BuildContext context) {
    final scale = lerpDouble(1, 1.02, _hover) ?? 1;

    return CursorRegion(
      child: MouseRegion(
        cursor: SystemMouseCursors.none,
        onEnter: (_) => setState(() => _hover = 1),
        onExit: (_) => setState(() => _hover = 0),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: GlassPanel(
            borderRadius: BorderRadius.circular(40),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.4,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.data.subtitle,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _hover,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.north_east, color: AppColors.primaryFixed),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedScale(
                          scale: lerpDouble(1.10, 1.0, _hover) ?? 1.0,
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          child: Image.asset(widget.data.assetPath, fit: BoxFit.cover),
                        ),
                        AnimatedOpacity(
                          opacity: _hover,
                          duration: const Duration(milliseconds: 200),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColors.surfaceDim.withValues(alpha: 0.40),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactSection extends StatefulWidget {
  const _ContactSection({super.key});

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  late final TextEditingController ctrlName;
  late final TextEditingController ctrlEmail;
  late final TextEditingController ctrlMessage;

  @override
  void initState() {
    super.initState();
    ctrlName = TextEditingController();
    ctrlEmail = TextEditingController();
    ctrlMessage = TextEditingController();
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 120, 24, 120),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Text(
                "LET'S COLLABORATE",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      fontSize: 54,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Have a vision? Let's manifest it into reality.",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w300,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              GlassPanel(
                borderRadius: BorderRadius.circular(64),
                padding: const EdgeInsets.all(28),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 640;
                        final children = [
                          Expanded(
                            child: _LabeledField(
                              label: 'Your Name',
                              controller: ctrlName,
                              hintText: 'Adil Ashfaq',
                            ),
                          ),
                          const SizedBox(width: 20, height: 20),
                          Expanded(
                            child: _LabeledField(
                              label: 'Email Address',
                              controller: ctrlEmail,
                              hintText: 'hello@neon.com',
                            ),
                          ),
                        ];
                        return isWide
                            ? Row(children: children)
                            : Column(
                                children: [
                                  _LabeledField(
                                    label: 'Your Name',
                                    controller: ctrlName,
                                    hintText: 'Adil Ashfaq',
                                  ),
                                  const SizedBox(height: 20),
                                  _LabeledField(
                                    label: 'Email Address',
                                    controller: ctrlEmail,
                                    hintText: 'hello@neon.com',
                                  ),
                                ],
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    _LabeledField(
                      label: 'Your Message',
                      controller: ctrlMessage,
                      hintText: 'Tell me about your project...',
                      maxLines: 6,
                    ),
                    const SizedBox(height: 20),
                    NeonButton(
                      label: 'SEND MESSAGE',
                      onPressed: () {},
                      isFullWidth: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'email@eliasize.com',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                      fontWeight: FontWeight.w300,
                      fontSize: 28,
                    ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _SocialLink(icon: Icons.public, label: 'LinkedIn'),
                  SizedBox(width: 48),
                  _SocialLink(icon: Icons.code, label: 'GitHub'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.10)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryFixed,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  fontSize: 10,
                ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.20)),
            filled: true,
            fillColor: AppColors.white.withValues(alpha: 0.05),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: AppColors.primaryFixed, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          ),
        ),
      ],
    );
  }
}

class _SocialLink extends StatefulWidget {
  const _SocialLink({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  double _hover = 0;

  @override
  Widget build(BuildContext context) {
    return CursorRegion(
      child: MouseRegion(
        cursor: SystemMouseCursors.none,
        onEnter: (_) => setState(() => _hover = 1),
        onExit: (_) => setState(() => _hover = 0),
        child: Column(
          children: [
            AnimatedSlide(
              offset: Offset(0, lerpDouble(0, -0.06, _hover) ?? 0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              child: Icon(widget.icon, size: 40, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 10),
            Text(
              widget.label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.white.withValues(alpha: 0.05))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 760;
              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _FooterCopy(),
                        _FooterLinks(),
                      ],
                    )
                  : const Column(
                      children: [
                        _FooterCopy(),
                        SizedBox(height: 18),
                        _FooterLinks(),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _FooterCopy extends StatelessWidget {
  const _FooterCopy();

  @override
  Widget build(BuildContext context) {
    return Text(
      '© 2024 NEON ARCHITECT. CRAFTED WITH FLUTTER & PASSION.',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.35),
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
            fontSize: 10,
          ),
      textAlign: TextAlign.center,
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks();

  @override
  Widget build(BuildContext context) {
    Widget link(String label) {
      return InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                  fontSize: 10,
                ),
          ),
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        link('Twitter'),
        link('Instagram'),
        link('Behance'),
      ],
    );
  }
}

