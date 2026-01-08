import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';

/// Button variant types
enum SSButtonVariant {
  primary,
  secondary,
  text,
  danger,
}

/// ServiceSentinel Button Component
///
/// A themed button component with multiple variants.
/// All colors come from theme, making it theme-aware.
class SSButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final SSButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double? height;

  const SSButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = SSButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height,
  });

  /// Primary button constructor
  const SSButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height,
  }) : variant = SSButtonVariant.primary;

  /// Secondary button constructor
  const SSButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height,
  }) : variant = SSButtonVariant.secondary;

  /// Text button constructor
  const SSButton.text({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height,
  }) : variant = SSButtonVariant.text;

  /// Danger button constructor
  const SSButton.danger({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height,
  }) : variant = SSButtonVariant.danger;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget button;

    switch (variant) {
      case SSButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildContent(context),
        );
        break;

      case SSButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildContent(context),
        );
        break;

      case SSButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          child: _buildContent(context),
        );
        break;

      case SSButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: Colors.white,
          ),
          child: _buildContent(context),
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height ?? 48,
        child: button,
      );
    }

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height ?? 48,
        child: button,
      );
    }

    return button;
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == SSButtonVariant.secondary || variant == SSButtonVariant.text
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text, style: AppTypography.button),
        ],
      );
    }

    return Text(text, style: AppTypography.button);
  }
}
