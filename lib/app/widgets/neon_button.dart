import 'package:flutter/material.dart';

import 'custom_cursor.dart';
import '../theme/app_colors.dart';

class NeonButton extends StatelessWidget {
  const NeonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    this.isFullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final child = DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryFixed, AppColors.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryFixed.withValues(alpha: 0.18),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.surfaceDim,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
        ),
      ),
    );

    return CursorRegion(
      enabled: onPressed != null,
      child: GestureDetector(
        onTap: onPressed,
        child: isFullWidth ? SizedBox(width: double.infinity, child: child) : child,
      ),
    );
  }
}

