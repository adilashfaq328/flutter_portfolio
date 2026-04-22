import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FloatingBlobs extends StatefulWidget {
  const FloatingBlobs({super.key});

  @override
  State<FloatingBlobs> createState() => _FloatingBlobsState();
}

class _FloatingBlobsState extends State<FloatingBlobs> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeInOut.transform(_controller.value);
          final dy = lerpDouble(0, -20, t) ?? 0;
          final dx = lerpDouble(0, 10, t) ?? 0;

          return Stack(
            children: [
              _Blob(
                color: AppColors.primaryFixed,
                size: 500,
                top: -80 + dy,
                left: -80 + dx,
              ),
              _Blob(
                color: AppColors.secondary,
                size: 400,
                top: MediaQuery.sizeOf(context).height * 0.60 + dy * 0.6,
                right: -40 + dx * 0.6,
              ),
              _Blob(
                color: AppColors.primaryContainer,
                size: 300,
                bottom: 80 + math.sin(t * math.pi) * 12,
                left: MediaQuery.sizeOf(context).width * 0.20 + dx * 0.4,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.size,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  final Color color;
  final double size;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Opacity(
        opacity: 0.15,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: SizedBox(width: size, height: size),
          ),
        ),
      ),
    );
  }
}

