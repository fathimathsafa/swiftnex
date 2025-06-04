import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  const DeliveryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        centerTitle: true,
      title: Text('Order Details', style: AppTheme.headingSmall),
         leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: const Color(0xFF1A1A1A),
          size: 20.sp,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              _buildStatusSection(),
              SizedBox(height: 16.h),
              _buildProductSection(),
              SizedBox(height: 16.h),
              _buildDeliveryInfoSection(),
              SizedBox(height: 16.h),
              _buildPricingSection(),
              SizedBox(height: 24.h),
              _buildActionButtons(context),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildStatusSection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(Icons.check, color: Colors.white, size: 30.sp),
          ),
          SizedBox(height: 12.h),
          Text('Order Delivered', style: AppTheme.headingSmall),
          SizedBox(height: 4.h),
          Text('December 15, 2024 • 2:30 PM', style: AppTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Items', style: AppTheme.headingSmall),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1508616185939-efe767994166?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8YXNpYW4lMjBiYWYlMjBicmVhZHxlbnwwfHx8fDE2OTc4Nzg3NTd8MA&ixlib=rb-4.0.3&q=80&w=1080',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Burger', style: AppTheme.headingSmall),
                    SizedBox(height: 4.h),
                    Text('Delinas Resto', style: AppTheme.bodyMedium),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Text('Qty: 1', style: AppTheme.bodyMedium),
                        const Spacer(),
                        Text('\$35.05', style: AppTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Information', style: AppTheme.headingSmall),
          SizedBox(height: 16.h),
          _buildInfoRow(
            icon: Icons.person_outline,
            label: 'Delivery Partner',
            value: 'Rajesh Kumar',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.access_time_outlined,
            label: 'Delivery Time',
            value: '25 minutes',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Delivered To',
            value: 'Home\n123 MG Road, Thrissur, Kerala',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(icon, size: 20.sp, color: const Color(0xFF757575)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTheme.bodyMedium),
              SizedBox(height: 2.h),
              Text(value, style: AppTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPricingSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bill Details', style: AppTheme.headingSmall),
          SizedBox(height: 16.h),
          _buildBillRow('Item Total', '\$35.05'),
          SizedBox(height: 8.h),
          _buildBillRow('Delivery Fee', '\$25'),
          SizedBox(height: 8.h),
          _buildBillRow('Taxes & Charges', '\$16'),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFFE8E8E8)),
          SizedBox(height: 8.h),
          _buildBillRow('Total Paid', '\$76', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildBillRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyMedium),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isTotal ? const Color(0xFF1A1A1A) : const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFF6B35)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              'Rate Order',
              style: AppTheme.bodyMedium?.copyWith(color: AppTheme.primary),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainBottomNavigationScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              elevation: 0,
            ),
            child: Text(
              'Reorder',
              style: AppTheme.bodyMedium?.copyWith(color: AppTheme.background),
            ),
          ),
        ),
      ],
    );
  }
}
