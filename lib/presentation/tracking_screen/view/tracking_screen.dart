import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';

class FoodDeliveryTrackingScreen extends StatefulWidget {
  const FoodDeliveryTrackingScreen({Key? key}) : super(key: key);

  @override
  State<FoodDeliveryTrackingScreen> createState() =>
      _FoodDeliveryTrackingScreenState();
}

class _FoodDeliveryTrackingScreenState extends State<FoodDeliveryTrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int deliveryTime = 10;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startCountdown();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && deliveryTime > 0) {
        setState(() => deliveryTime--);
        if (deliveryTime > 0) _startCountdown();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Order Tracking', style: AppTheme.headingSmall),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildStatusCard(), _buildAnimation(), _buildOkButton()],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary),
      ),
      child: Column(
        children: [
          const Icon(Icons.delivery_dining, color: AppTheme.primary, size: 40),
          const SizedBox(height: 12),
          const Text(
            'Your food is on the way',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Estimated delivery time',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$deliveryTime minutes',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return SizedBox(
      width: 280,
      height: 280,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(280, 280),
            painter: DeliveryPainter(_animation.value),
          );
        },
      ),
    );
  }

  Widget _buildOkButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainBottomNavigationScreen(),
              ),
            ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'OK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class DeliveryPainter extends CustomPainter {
  final double progress;

  DeliveryPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 40;

    _drawTrack(canvas, center, radius);
    _drawProgress(canvas, center, radius);
    _drawDeliveryBike(canvas, center, radius);
    _drawLocations(canvas, center, radius);
  }

  void _drawTrack(Canvas canvas, Offset center, double radius) {
    final paint =
        Paint()
          ..color = Colors.grey.shade300
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);
  }

  void _drawProgress(Canvas canvas, Offset center, double radius) {
    final paint =
        Paint()
          ..color = AppTheme.primary
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  void _drawDeliveryBike(Canvas canvas, Offset center, double radius) {
    final angle = 2 * math.pi * progress - math.pi / 2;
    final bikeX = center.dx + radius * math.cos(angle);
    final bikeY = center.dy + radius * math.sin(angle);

    final paint =
        Paint()
          ..color = AppTheme.primary
          ..style = PaintingStyle.fill;

    // Simple bike representation
    canvas.drawCircle(Offset(bikeX, bikeY), 8, paint);

    // Bike icon indicator
    final iconPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(bikeX, bikeY), 4, iconPaint);
  }

  void _drawLocations(Canvas canvas, Offset center, double radius) {
    // Restaurant (top)
    _drawLocationPin(
      canvas,
      Offset(center.dx, center.dy - radius - 20),
      AppTheme.primary,
    );

    // Home (bottom)
    _drawLocationPin(
      canvas,
      Offset(center.dx, center.dy + radius + 20),
      Colors.green,
    );
  }

  void _drawLocationPin(Canvas canvas, Offset position, Color color) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 15, paint);

    final iconPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(position, 8, iconPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
