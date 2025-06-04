import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/cart_screen/controller/cart_controller.dart';
import 'package:swiftnex/presentation/cart_screen/view/cart_screen.dart';

class MenuDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;

  const MenuDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  State<MenuDetailScreen> createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  int quantity = 1;
  PageController pageController = PageController();
  PageController secondPageController = PageController();
  int currentImageIndex = 0;
  int currentSecondImageIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    secondPageController.dispose();
    super.dispose();
  }

void addToCart() {
  // Generate unique ID for the item
  final itemId = '${widget.title}_${DateTime.now().millisecondsSinceEpoch}';

  // Access CartService singleton instance
  CartService().addToCart(
    itemId,
    widget.title,
    widget.price,
    widget.imageUrl,
    quantity,
  );

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${widget.title} added to cart!'),
      backgroundColor: const Color(0xFFFF6B35),
      duration: const Duration(seconds: 2),
    ),
  );

  // Navigate to CartScreen after a short delay
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyCartScreen()),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Section with Navigation
            Container(
              height: 400.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.r),
                        bottomRight: Radius.circular(24.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppTheme.background,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 400.h,
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Noodles', style: AppTheme.bodySmall),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: AppTheme.bodyLarge?.copyWith(
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 16.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              quantity.toString(),
                              style: AppTheme.bodyLarge?.copyWith(
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 16.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Rating, Calories, Time
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating', style: AppTheme.bodySmall),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.star, color: const Color(0xFFFF6B35), size: 16.sp),
                                SizedBox(width: 4.w),
                                Text('4.8', style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 40.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Calories', style: AppTheme.bodySmall),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.local_fire_department, color: const Color(0xFFFF6B35), size: 16.sp),
                                SizedBox(width: 4.w),
                                Text('124 Kcal', style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 40.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time', style: AppTheme.bodySmall),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.access_time, color: const Color(0xFFFF6B35), size: 16.sp),
                                SizedBox(width: 4.w),
                                Text('15 min', style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    Text(
                      'Description',
                      style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Delicious fried grill noodles with perfectly cooked egg special. Made with fresh vegetables, premium noodles, and our signature sauce blend. A perfect combination of flavors that will satisfy your taste buds.',
                      style: AppTheme.bodySmall,
                    ),

                    SizedBox(height: 24.h),

                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Price and Add to Cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$',
                                style: TextStyle(
                                  color: const Color(0xFFFF6B35),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: widget.price.toStringAsFixed(2),
                                style: AppTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: addToCart, // Added cart functionality here
                          child: Container(
                            width: 180.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B35),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 15.sp),
                                SizedBox(width: 8.w),
                                Text(
                                  'Add to Cart',
                                  style: AppTheme.bodySmall?.copyWith(
                                    color: AppTheme.background,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}