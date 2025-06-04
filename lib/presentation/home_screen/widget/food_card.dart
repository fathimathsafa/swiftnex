import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/product_details_screen/view/product_details_screen.dart';

class HorizontalFoodCardsWidget extends StatelessWidget {
  final List<FoodCardItem> foodItems;
  final double cardWidth;
  final double cardHeight;
  final EdgeInsets padding;

  const HorizontalFoodCardsWidget({
    Key? key,
    required this.foodItems,
    this.cardWidth = 200.0,
    this.cardHeight = 250.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: foodItems.map((item) {
            return Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: _buildFoodCard(context, item),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, FoodCardItem item) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MenuDetailScreen(  imageUrl: item.imageUrl,
      title: item.name,
      price: item.price,
              
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [_buildCardImage(item), _buildCardOverlay(context, item)],
        ),
      ),
    );
  }

  Widget _buildCardImage(FoodCardItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: item.isAsset
          ? Image.asset(
              item.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 500),
              fadeOutDuration: Duration(milliseconds: 500),
              imageUrl: item.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(Icons.error),
              ),
            ),
    );
  }

  Widget _buildCardOverlay(BuildContext context, FoodCardItem item) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRatingBadge(item.rating),
        _buildInfoSection(context, item),
      ],
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Padding(
      padding: EdgeInsets.all(14.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x7F191D31),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 2.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.star, color: AppTheme.warning, size: 12.sp),
                        Text(
                          " ${rating.toStringAsFixed(1)}",
                          style: AppTheme.bodySmallWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, FoodCardItem item) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x7F191D31),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 2.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppTheme.bodySmallWhite,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "\$",
                                style: AppTheme.bodySmallOrange,
                              ),
                              TextSpan(
                                text: item.price.toStringAsFixed(2),
                                style: AppTheme.bodySmallWhite,
                              ),
                            ],
                            style: AppTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data model for food card items
class FoodCardItem {
  final String name;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isAsset;
  final String? description;
  final String? category;

  FoodCardItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isAsset = false,
    this.description,
    this.category,
  });
}
