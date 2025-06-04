import 'package:flutter/material.dart';

// Simple Button Widget
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.enabled = true,
    this.fontSize,
    this.fontWeight,
  });

  // Required properties
  final String text;
  final VoidCallback? onPressed;

  // Optional styling
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isLoading;
  final bool enabled;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Default values
    final buttonColor = widget.color ?? Theme.of(context).primaryColor;
    final textColor = widget.textColor ?? Colors.white;
    final height = widget.height ?? 50.0;
    final borderRadius = widget.borderRadius ?? 8.0;
    final fontSize = widget.fontSize ?? 16.0;
    final fontWeight = widget.fontWeight ?? FontWeight.w500;

    // Button content
    Widget content;
    
    if (widget.isLoading) {
      // Show loading indicator
      content = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    } else if (widget.icon != null) {
      // Show icon + text
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: fontSize + 2, color: textColor),
          SizedBox(width: 8),
          Text(
            widget.text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      );
    } else {
      // Show text only
      content = Text(
        widget.text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: widget.width,
        height: height,
        decoration: BoxDecoration(
          color: widget.enabled 
              ? (_isPressed ? buttonColor.withOpacity(0.8) : buttonColor)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: widget.enabled && !_isPressed
              ? [
                  BoxShadow(
                    color: buttonColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: (widget.enabled && !widget.isLoading) ? widget.onPressed : null,
            child: Container(
              alignment: Alignment.center,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

// Predefined button styles for common use cases
class ButtonStyles {
  // Primary button
  static AppButton primary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      color: Color(0xFF2196F3), // Blue
      textColor: Colors.white,
    );
  }

  // Secondary button
  static AppButton secondary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      color: Color(0xFF6C757D), // Gray
      textColor: Colors.white,
    );
  }

  // Success button
  static AppButton success({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      color: Color(0xFF28A745), // Green
      textColor: Colors.white,
    );
  }

  // Danger button
  static AppButton danger({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      width: width,
      isLoading: isLoading,
      color: Color(0xFFDC3545), // Red
      textColor: Colors.white,
    );
  }

  // Outline button
  static Widget outline({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    bool isLoading = false,
    Color? borderColor,
  }) {
    final color = borderColor ?? Color(0xFF2196F3);
    
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppButton(
        text: text,
        onPressed: onPressed,
        icon: icon,
        isLoading: isLoading,
        color: Colors.transparent,
        textColor: color,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}