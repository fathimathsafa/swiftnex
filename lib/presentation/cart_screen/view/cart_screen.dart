
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/cart_screen/controller/cart_controller.dart';
import 'package:swiftnex/presentation/checkout_screen/view/checkout_screen.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  double get orderTotal {
    return _cartService.subtotal;
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
                      color:AppTheme.textPrimary,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'My Cart',
                    style: AppTheme.headingMedium,
                  ),
                ],
              ),
            ),
            
            // Cart Items List
            Expanded(
              child: Container(
                color: Colors.white,
                child: _cartService.items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80.sp,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Your cart is empty',
                              style: AppTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                        itemCount: _cartService.items.length,
                        separatorBuilder: (context, index) => SizedBox(height: 20.h),
                        itemBuilder: (context, index) {
                          final item = _cartService.items[index];
                          return CartItemWidget(
                            cartItem: item,
                            onQuantityChanged: (newQuantity) {
                              _cartService.updateQuantity(item.id, newQuantity);
                            },
                          );
                        },
                      ),
              ),
            ),
            
            // Bottom Section with Total and Checkout
            if (_cartService.items.isNotEmpty)
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    // Order Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Total',
                          style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary,)
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$',
                                style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary,)
                              ),
                              TextSpan(
                                text: orderTotal.toStringAsFixed(2),
                                 style: AppTheme.bodyLarge?.copyWith(color: AppTheme.textPrimary,)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Checkout Button
                    GestureDetector(
                      onTap: () {
                        // Navigate to checkout screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                        );
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
                            'Checkout',
                            style: AppTheme.bodyLarge?.copyWith(
                     color: AppTheme.background,
  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Food Image
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
              image: NetworkImage(cartItem.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        SizedBox(width: 16.w),
        
        // Item Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.name,
                style:  AppTheme.bodyMedium?.copyWith(
                         color: AppTheme.textPrimary,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                 style: AppTheme.bodySmall
                    ),
                    TextSpan(
                      text: cartItem.price.toStringAsFixed(2),
                      style: AppTheme.bodySmall?.copyWith(
                         color: AppTheme.textPrimary,
                     ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(width: 16.w),
        
        // Quantity Controls
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (cartItem.quantity > 0) {
                    onQuantityChanged(cartItem.quantity - 1);
                  }
                },
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Container(
                width: 40.w,
                child: Center(
                  child: Text(
                    cartItem.quantity.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onQuantityChanged(cartItem.quantity + 1);
                },
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
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
        ),
      ],
    );
  }
}