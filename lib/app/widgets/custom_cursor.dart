import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CursorController extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isHoveringInteractive = false;

  Offset get position => _position;
  bool get isHoveringInteractive => _isHoveringInteractive;

  void updatePosition(Offset position) {
    if (_position == position) return;
    _position = position;
    notifyListeners();
  }

  void setInteractiveHover(bool value) {
    if (_isHoveringInteractive == value) return;
    _isHoveringInteractive = value;
    notifyListeners();
  }
}

class CursorScope extends InheritedNotifier<CursorController> {
  const CursorScope({
    super.key,
    required CursorController controller,
    required super.child,
  }) : super(notifier: controller);

  static CursorController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CursorScope>();
    assert(scope != null, 'CursorScope not found in widget tree');
    return scope!.notifier!;
  }
}

class CustomCursor extends StatefulWidget {
  const CustomCursor({super.key, required this.child});

  final Widget child;

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  late final CursorController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CursorController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Custom cursor is intended for Flutter Web/desktop only.
    final enabled = kIsWeb ||
        {
          TargetPlatform.macOS,
          TargetPlatform.linux,
          TargetPlatform.windows,
        }.contains(defaultTargetPlatform);

    if (!enabled) return widget.child;

    return CursorScope(
      controller: _controller,
      child: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (e) => _controller.updatePosition(e.position),
        child: Stack(
          children: [
            widget.child,
            const _CursorOverlay(),
          ],
        ),
      ),
    );
  }
}

class CursorRegion extends StatelessWidget {
  const CursorRegion({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => CursorScope.of(context).setInteractiveHover(true),
      onExit: (_) => CursorScope.of(context).setInteractiveHover(false),
      child: child,
    );
  }
}

class _CursorOverlay extends StatelessWidget {
  const _CursorOverlay();

  @override
  Widget build(BuildContext context) {
    final c = CursorScope.of(context);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: c,
        builder: (context, _) {
          final p = c.position;
          final hovering = c.isHoveringInteractive;

          // Matches HTML: dot scales up on hover, outer ring scales too.
          final dotScale = hovering ? 4.0 : 1.0;
          final outerScale = hovering ? 1.5 : 1.0;

          final dotColor = hovering
              ? AppColors.primaryFixed.withValues(alpha: 0.20)
              : AppColors.primaryFixed;

          final outerColor = hovering
              ? AppColors.primaryFixed
              : AppColors.primaryFixed.withValues(alpha: 0.50);

          // HTML places dot at mouse position (top-left anchored translate).
          // We'll center the widgets on the pointer for a closer match.
          return Stack(
            children: [
              Positioned(
                left: p.dx - 6,
                top: p.dy - 6,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()..scaleByDouble(dotScale, dotScale, 1, 1),
                  transformAlignment: Alignment.center,
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: p.dx - 20,
                top: p.dy - 20,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()..scaleByDouble(outerScale, outerScale, 1, 1),
                  transformAlignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: outerColor, width: 1),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

