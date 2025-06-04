import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

import 'package:swiftnex/core/constants/app_theme.dart';

class EnhancedFoodCardsWidget extends StatelessWidget {
  final List<FoodCardData> foodItems;
  final double cardWidth;
  final double cardHeight;
  final EdgeInsets? padding;
  final double spacing;
  final Function(FoodCardData)? onCardTap;
  final bool showCurrency;
  final String currencySymbol;

  const EnhancedFoodCardsWidget({
    Key? key,
    required this.foodItems,
    this.cardWidth = 200.0,
    this.cardHeight = 250.0,
    this.padding,
    this.spacing = 16.0,
    this.onCardTap,
    this.showCurrency = true,
    this.currencySymbol = '\$',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children:
              foodItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < foodItems.length - 1 ? spacing : 0,
                  ),
                  child: _buildFoodCard(context, item),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, FoodCardData item) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onCardTap?.call(item),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [_buildCardImage(item), _buildCardOverlay(context, item)],
        ),
      ),
    );
  }

  Widget _buildCardImage(FoodCardData item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child:
          item.isAsset
              ? Image.asset(
                item.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => _buildErrorWidget(),
              )
              : CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 500),
                fadeOutDuration: Duration(milliseconds: 500),
                imageUrl: item.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildLoadingWidget(),
                errorWidget: (context, url, error) => _buildErrorWidget(),
              ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 40, color: Colors.grey[600]),
          SizedBox(height: 8.h),
          Text(
            'Image not available',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCardOverlay(BuildContext context, FoodCardData item) {
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
          _buildGlassMorphicContainer(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: AppTheme.warning, size: 12.sp),
                  Text(
                    " ${rating.toStringAsFixed(1)}",
                    style: AppTheme.bodySmallWhite,
                  ),
                ],
              ),
            ),
            borderRadius: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, FoodCardData item) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: _buildGlassMorphicContainer(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTheme.bodySmallWhite,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    _buildPriceText(context, item.price),
                    if (item.description != null) ...[
                      SizedBox(height: 2.0),
                      Text(
                        item.description!,
                        style: AppTheme.bodySmallWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              borderRadius: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceText(BuildContext context, double price) {
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      text: TextSpan(
        children: [
          if (showCurrency)
            TextSpan(text: currencySymbol, style: AppTheme.bodySmallOrange),
          TextSpan(
            text: price.toStringAsFixed(2),
            style: AppTheme.bodySmallWhite?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        style: AppTheme.bodySmallWhite,
      ),
    );
  }

  Widget _buildGlassMorphicContainer({
    required Widget child,
    required double borderRadius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x7F191D31),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 2.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Enhanced data model for food cards
class FoodCardData {
  final String name;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isAsset;
  final String? description;
  final String? category;
  final List<String>? tags;
  final bool isPopular;
  final bool isNew;

  FoodCardData({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isAsset = false,
    this.description,
    this.category,
    this.tags,
    this.isPopular = false,
    this.isNew = false,
  });

  // Factory constructor for easy creation from JSON
  factory FoodCardData.fromJson(Map<String, dynamic> json) {
    return FoodCardData(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isAsset: json['isAsset'] ?? false,
      description: json['description'],
      category: json['category'],
      tags: json['tags']?.cast<String>(),
      isPopular: json['isPopular'] ?? false,
      isNew: json['isNew'] ?? false,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'isAsset': isAsset,
      'description': description,
      'category': category,
      'tags': tags,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }
}
