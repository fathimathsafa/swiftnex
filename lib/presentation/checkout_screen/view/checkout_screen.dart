import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/cart_screen/controller/cart_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController voucherController = TextEditingController();
  double shippingCost = 5.31;
  final CartService _cartService = CartService();

  // Get subtotal from cart instead of hardcoded value
  double get subtotal => _cartService.subtotal;

  double get total => shippingCost + subtotal;

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    voucherController.dispose();
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24.sp,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Checkout', style: AppTheme.headingMedium),
                    ),
                  ),
                  SizedBox(width: 24.w), // Balance the back button
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Address', style: AppTheme.headingSmall),
                          Text(
                            'Edit',
                            style: AppTheme.headingSmall?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Address Card
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            // Map Icon
                            Container(
                              width: 60.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Stack(
                                children: [
                                  // Map background with light blue and teal colors
                                  Container(
                                    width: 60.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: CustomPaint(
                                      painter: SimpleMapPainter(),
                                    ),
                                  ),
                                  // Location pin
                                  Positioned(
                                    top: 15.h,
                                    left: 20.w,
                                    child: Container(
                                      width: 20.w,
                                      height: 20.h,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF6B35),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 16.w),

                            // Address Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home_outlined,
                                        color: const Color(0xFF4DD0E1),
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text('House', style: AppTheme.bodySmall),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    '5482 Adobe Falls Rd #15San\nDiego, California(CA), 92120',
                                    style: AppTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Payment Method Section
                      Text('Payment Method', style: AppTheme.headingSmall),

                      SizedBox(height: 16.h),

                      // Payment Method Card
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Mastercard Icon
                            Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8EAF0),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Icon(
                                    Icons.credit_card,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 16.w),

                            // Card Details
                            InkWell(
                              onTap: () {
                                showPaymentMethodBottomSheet(context);
                              },
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Master Card',
                                      style: AppTheme.bodyLarge,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '•••• •••• 1234',
                                      style: AppTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Arrow Icon
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                              size: 24.sp,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Voucher Code Section
                      Text('Voucher Code', style: AppTheme.headingSmall),

                      SizedBox(height: 16.h),

                      // Voucher Input
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: voucherController,
                          decoration: InputDecoration(
                            hintText: 'Enter voucher code',
                            hintStyle: AppTheme.bodyLarge,
                            prefixIcon: Container(
                              padding: EdgeInsets.all(12.w),
                              child: Icon(
                                Icons.confirmation_number_outlined,
                                color: Colors.grey[600],
                                size: 20.sp,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Price Breakdown
                      Column(
                        children: [
                          // Shipping Cost
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping cost', style: AppTheme.bodyMedium),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\$',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    TextSpan(
                                      text: shippingCost.toStringAsFixed(2),
                                      style: AppTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Subtotal
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sub total', style: AppTheme.bodyMedium),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\$',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    TextSpan(
                                      text: subtotal.toStringAsFixed(2),
                                      style: AppTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Divider
                          Container(
                            height: 1.h,
                            child: Row(
                              children: List.generate(
                                (MediaQuery.of(context).size.width / 6).floor(),
                                (index) => Expanded(
                                  child: Container(
                                    height: 1.h,
                                    color:
                                        index % 2 == 0
                                            ? Colors.grey[400]
                                            : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: AppTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\$',
                                      style: AppTheme.bodyLarge?.copyWith(
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: total.toStringAsFixed(2),
                                      style: AppTheme.bodyLarge?.copyWith(
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      // Checkout Button
                      InkWell(
                        onTap: () {
                          showOrderSuccessBottomSheet(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: Text(
                              'Checkout Now',
                              style: AppTheme.headingSmall?.copyWith(
                                color: AppTheme.background,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Light blue background
    final bgPaint = Paint()..color = const Color(0xFFE1F5FE);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
      bgPaint,
    );

    // Teal/cyan shapes
    final shapePaint = Paint()..color = const Color(0xFF4DD0E1);

    // Draw some geometric shapes to represent map areas
    final path = Path();

    // Left side shape
    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width * 0.4, size.height * 0.2);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.lineTo(0, size.height * 0.8);
    path.close();

    canvas.drawPath(path, shapePaint);

    // Right side shape
    final path2 = Path();
    path2.moveTo(size.width * 0.6, 0);
    path2.lineTo(size.width, size.height * 0.1);
    path2.lineTo(size.width, size.height * 0.5);
    path2.lineTo(size.width * 0.7, size.height * 0.4);
    path2.close();

    canvas.drawPath(path2, shapePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void showPaymentMethodBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F2F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildPaymentOption(
                  icon: Icons.paypal,
                  title: 'Paypal',
                  subtitle: 'sask****@gmail.com',
                ),
                SizedBox(height: 12.h),
                _buildPaymentOption(
                  icon: Icons.credit_card,
                  title: 'Mastercard',
                  subtitle: '4827 8472 7424 ****',
                ),
                SizedBox(height: 12.h),
                _buildAddPaymentOption(),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Apply the payment method',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildPaymentOption({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Colors.black, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
        ),
        Icon(Icons.radio_button_unchecked, size: 20.sp),
      ],
    ),
  );
}

Widget _buildAddPaymentOption() {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.add, color: Colors.black, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Text(
          "Add Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ],
    ),
  );
}

void showOrderSuccessBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.55,
        maxChildSize: 0.8,
        minChildSize: 0.4,
        builder: (_, controller) {
          return Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F2F5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                Flexible(
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/706/706797.png',
                        width: 80.w,
                        height: 80.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                Flexible(
                  child: Text(
                    "Order Success",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
