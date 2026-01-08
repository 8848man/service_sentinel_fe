import 'package:flutter/material.dart';

/// ServiceSentinel Icon Component
///
/// A theme-aware icon wrapper with consistent sizing.
class SSIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const SSIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
  });

  /// Small icon (16px)
  const SSIcon.small({
    super.key,
    required this.icon,
    this.color,
  }) : size = 16;

  /// Medium icon (24px)
  const SSIcon.medium({
    super.key,
    required this.icon,
    this.color,
  }) : size = 24;

  /// Large icon (32px)
  const SSIcon.large({
    super.key,
    required this.icon,
    this.color,
  }) : size = 32;

  /// Extra large icon (48px)
  const SSIcon.xlarge({
    super.key,
    required this.icon,
    this.color,
  }) : size = 48;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 24,
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }
}
