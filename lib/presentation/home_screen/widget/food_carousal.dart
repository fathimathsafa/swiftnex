import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/cart_screen/view/cart_screen.dart';

class FoodCarouselWidget extends StatefulWidget {
  final List<FoodItem> foodItems;
  final String location;
  final int cartCount;
  final int notificationCount;
  final VoidCallback? onMenuTap;
  final VoidCallback? onCartTap;
  final Function(String)? onSearch;
  final String searchHint;

  const FoodCarouselWidget({
    Key? key,
    required this.foodItems,
    required this.location,
    this.cartCount = 0,
    this.notificationCount = 0,
    this.onMenuTap,
    this.onCartTap,
    this.onSearch,
    this.searchHint = "Let's find the food you like",
  }) : super(key: key);

  @override
  State<FoodCarouselWidget> createState() => _FoodCarouselWidgetState();
}

class _FoodCarouselWidgetState extends State<FoodCarouselWidget> {
  late PageController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.r),
        bottomRight: Radius.circular(40.r),
        topLeft: Radius.circular(0.0),
        topRight: Radius.circular(0.0),
      ),
      child: Container(
        height: 350.0,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.r),
            bottomRight: Radius.circular(40.r),
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
        ),
        child: Stack(
          children: [_buildCarousel(), _buildHeader(), _buildSearchBar()],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.foodItems.length,
              itemBuilder: (context, index) {
                return _buildCarouselItem(widget.foodItems[index]);
              },
            ),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(FoodItem item) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _buildBackgroundImage(item.imageUrl),
          _buildGradientOverlay(),
          Center(child: _buildItemContent(item)),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.r),
        bottomRight: Radius.circular(40.r),
        topLeft: Radius.circular(0.0),
        topRight: Radius.circular(0.0),
      ),
      child: CachedNetworkImage(
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutDuration: Duration(milliseconds: 500),
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              color: Colors.grey[300],
              child: Center(child: CircularProgressIndicator()),
            ),
        errorWidget:
            (context, url, error) =>
                Container(color: Colors.grey[300], child: Icon(Icons.error)),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x8214181B), Color(0x4014181B)],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(0.0, -1.0),
          end: AlignmentDirectional(0, 1.0),
        ),
      ),
    );
  }

  Widget _buildItemContent(FoodItem item) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(item.name, style: AppTheme.buttonText),
        SizedBox(height: 8.h),
        RichText(
          textScaler: MediaQuery.of(context).textScaler,
          text: TextSpan(
            children: [TextSpan(text: item.offer, style: AppTheme.buttonText2)],
            style: AppTheme.bodySmallWhite,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          item.description,
          style: AppTheme.bodySmallWhite,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 10.0),
        child: smooth_page_indicator.SmoothPageIndicator(
          controller: _controller,
          count: widget.foodItems.length,
          axisDirection: Axis.horizontal,
          effect: smooth_page_indicator.SlideEffect(
            spacing: 4.0,
            radius: 8.r,
            dotWidth: 16.w,
            dotHeight: 4.h,
            dotColor: AppTheme.textSecondary,
            activeDotColor: AppTheme.primary,
            paintStyle: PaintingStyle.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 44.0, 24.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildLocationInfo(), _buildCartButton()],
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Location", style: AppTheme.bodySmallWhite),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: AppTheme.primary, size: 14.r),
              Flexible(
                child: Text(widget.location, style: AppTheme.bodySmallWhite),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyCartScreen()),
        );
      },
      child: Icon(Icons.shopping_cart, color: AppTheme.background, size: 24.r),
    );
  }

  Widget _buildSearchBar() {
    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15.0,
                  color: Color(0x66000000),
                  offset: Offset(0.0, 4.0),
                ),
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    autofocus: false,
                    obscureText: false,
                    onChanged: widget.onSearch,
                    decoration: InputDecoration(
                      labelStyle: AppTheme.bodySmall,
                      hintText: widget.searchHint,
                      hintStyle: AppTheme.bodySmall,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.warning,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.warning,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.textPrimary,
                        size: 24.sp,
                      ),
                    ),
                    style: AppTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data model for food items
class FoodItem {
  final String name;
  final String offer;
  final String description;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.offer,
    required this.description,
    required this.imageUrl,
  });
}
