import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiftnex/presentation/home_screen/widget/category_button.dart';
import 'package:swiftnex/presentation/home_screen/widget/drawer.dart';
import 'package:swiftnex/presentation/home_screen/widget/enhanced_food_card.dart';
import 'package:swiftnex/presentation/home_screen/widget/food_card.dart';
import 'package:swiftnex/presentation/home_screen/widget/food_carousal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _controller = PageController();

  // Selected categories
  List<String> selectedCategories = ['All'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Fixed carousel items - same for all categories
  final List<FoodItem> fixedCarouselItems = [
    FoodItem(
      name: "Roast Beef",
      offer: "Buy 2 and Get 2",
      description: "The taste of the cake is world...",
      imageUrl:
          'https://images.unsplash.com/photo-1630071074184-a879a29c51bb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxyb2FzdCUyMGJlYWZ8ZW58MHx8fHwxNjk3ODc4ODk5fDA&ixlib=rb-4.0.3&q=80&w=1080',
    ),
    FoodItem(
      name: "Asian Baf Bread",
      offer: "Buy 3 Get 1",
      description: "The taste of the cake is world...",
      imageUrl:
          'https://images.unsplash.com/photo-1508616185939-efe767994166?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyNHx8YXNpYW4lMjBiYWYlMjBicmVhZHxlbnwwfHx8fDE2OTc4Nzg3NTd8MA&ixlib=rb-4.0.3&q=80&w=1080',
    ),
    FoodItem(
      name: "Fried Chicken",
      offer: "Buy 3 Get 1",
      description: "The taste of the cake is world...",
      imageUrl:
          'https://images.unsplash.com/photo-1686772115119-40d9a96b5770?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxjaGlja2VuJTIwZnJpZXN8ZW58MHx8fHwxNjk3ODc4OTQyfDA&ixlib=rb-4.0.3&q=80&w=1080',
    ),
  ];

  // Hot deals with categories
  final Map<String, List<FoodCardItem>> categoryHotDeals = {
    'All': [
      FoodCardItem(
        name: "Viral stacking cake with honey",
        price: 9.67,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Delicious viral cake",
        category: "Dessert",
      ),
      FoodCardItem(
        name: "Roast beef with black pepper",
        price: 12.99,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Tender roast beef",
        category: "Main Course",
      ),
      FoodCardItem(
        name: "Grilled Salmon",
        price: 15.50,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1467003909585-2f8a72700288?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Fresh grilled salmon",
        category: "Seafood",
      ),
    ],
    'Meals': [
      FoodCardItem(
        name: "Premium Steak Meal",
        price: 24.99,
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Premium steak with sides",
        category: "Main Course",
      ),
      FoodCardItem(
        name: "Family Meal Deal",
        price: 35.99,
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Complete family meal",
        category: "Family",
      ),
    ],
    'Dinner': [
      FoodCardItem(
        name: "Romantic Dinner Set",
        price: 45.99,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1577215652871-b78d50c65150?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGRpbm5lciUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D',
        isAsset: false,
        description: "Perfect for date night",
        category: "Dinner",
      ),
      FoodCardItem(
        name: "Sunday Roast Dinner",
        price: 28.50,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Traditional Sunday roast",
        category: "Dinner",
      ),
    ],
    'Drinks': [
      FoodCardItem(
        name: "Tropical Smoothie",
        price: 6.99,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1666181767084-91e0cd358adf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dHJvcGljYWwlMjBzbW9vdGhpZXxlbnwwfHwwfHx8MA%3D%3D',
        isAsset: false,
        description: "Fresh tropical fruits",
        category: "Beverages",
      ),
      FoodCardItem(
        name: "Fresh Juice Combo",
        price: 8.99,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Mix of fresh juices",
        category: "Beverages",
      ),
    ],
    'Fast Foods': [
      FoodCardItem(
        name: "Double Cheeseburger",
        price: 8.99,
        rating: 4.3,
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Double the cheese",
        category: "Fast Food",
      ),
      FoodCardItem(
        name: "Chicken Wings Combo",
        price: 12.99,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1562967914-608f82629710?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Spicy chicken wings",
        category: "Fast Food",
      ),
    ],
    'Meat': [
      FoodCardItem(
        name: "BBQ Meat Platter",
        price: 32.99,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1544025162-d76694265947?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Mixed BBQ meats",
        category: "BBQ",
      ),
      FoodCardItem(
        name: "Premium Beef Cut",
        price: 28.99,
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        isAsset: false,
        description: "Premium quality beef",
        category: "Meat",
      ),
    ],
  };

  // Most bought items with categories
  final Map<String, List<FoodCardData>> categoryMostBought = {
    'All': [
      FoodCardData(
        name: "BBQ Chicken Wings",
        price: 8.99,
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1527477396000-e27163b481c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Spicy BBQ wings",
        category: "Appetizer",
        isPopular: true,
      ),
      FoodCardData(
        name: "Margherita Pizza",
        price: 14.50,
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Classic Italian pizza",
        category: "Main Course",
        isPopular: true,
      ),
      FoodCardData(
        name: "Caesar Salad",
        price: 7.25,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1546793665-c74683f339c1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Fresh crispy salad",
        category: "Salad",
        isNew: true,
      ),
      FoodCardData(
        name: "Chocolate Brownie",
        price: 5.99,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Rich chocolate dessert",
        category: "Dessert",
        isPopular: true,
      ),
    ],
    'Meals': [
      FoodCardData(
        name: "Power Lunch Box",
        price: 15.99,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Complete balanced meal",
        category: "Lunch",
        isPopular: true,
      ),
      FoodCardData(
        name: "Protein Bowl",
        price: 13.50,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "High protein meal",
        category: "Healthy",
        isNew: true,
      ),
    ],
    'Dinner': [
      FoodCardData(
        name: "Gourmet Dinner",
        price: 28.99,
        rating: 4.8,
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1699034727032-a54a380b03f6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZGlubmVyJTIwaW1hZ2VzfGVufDB8fDB8fHww',
        description: "Fine dining experience",
        category: "Fine Dining",
        isPopular: true,
      ),
      FoodCardData(
        name: "Family Dinner",
        price: 42.99,
        rating: 4.7,
        imageUrl:
            'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Perfect for family",
        category: "Family",
        isPopular: true,
      ),
    ],
    'Drinks': [
      FoodCardData(
        name: "Signature Smoothie",
        price: 7.99,
        rating: 4.6,
        imageUrl:
            'https://images.unsplash.com/photo-1539574610665-dc92264e9c4f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dHJvcGljYWwlMjBzbW9vdGhpZXxlbnwwfHwwfHx8MA%3D%3D',
        description: "House special smoothie",
        category: "Beverages",
        isPopular: true,
      ),
      FoodCardData(
        name: "Energy Drink",
        price: 4.99,
        rating: 4.3,
        imageUrl:
            'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Natural energy boost",
        category: "Beverages",
        isNew: true,
      ),
    ],
    'Fast Foods': [
      FoodCardData(
        name: "Mega Burger",
        price: 11.99,
        rating: 4.4,
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Our biggest burger",
        category: "Fast Food",
        isPopular: true,
      ),
      FoodCardData(
        name: "Loaded Fries",
        price: 6.99,
        rating: 4.5,
        imageUrl:
            'https://images.unsplash.com/photo-1562967914-608f82629710?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Fries with everything",
        category: "Fast Food",
        isPopular: true,
      ),
    ],
    'Meat': [
      FoodCardData(
        name: "Ribeye Steak",
        price: 35.99,
        rating: 4.9,
        imageUrl:
            'https://images.unsplash.com/photo-1544025162-d76694265947?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Premium ribeye cut",
        category: "Steak",
        isPopular: true,
      ),
      FoodCardData(
        name: "Lamb Chops",
        price: 29.99,
        rating: 4.8,
        imageUrl:
            'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080',
        description: "Tender lamb chops",
        category: "Meat",
        isPopular: true,
      ),
    ],
  };

  // Get filtered items based on selected categories (only for Hot Deals and Most Bought)
  List<FoodCardItem> get filteredHotDeals {
    if (selectedCategories.contains('All')) {
      return categoryHotDeals['All'] ?? [];
    }

    List<FoodCardItem> allItems = [];
    for (String category in selectedCategories) {
      allItems.addAll(categoryHotDeals[category] ?? []);
    }
    return allItems;
  }

  List<FoodCardData> get filteredMostBought {
    if (selectedCategories.contains('All')) {
      return categoryMostBought['All'] ?? [];
    }

    List<FoodCardData> allItems = [];
    for (String category in selectedCategories) {
      allItems.addAll(categoryMostBought[category] ?? []);
    }
    return allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppTheme.background,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Fixed carousel - same for all categories
                        FoodCarouselWidget(
                          foodItems:
                              fixedCarouselItems, // Always use the same carousel items
                          location: "San Diego, CA",
                          cartCount: 3,
                          notificationCount: 5,
                          onMenuTap: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          onCartTap: () => print("Cart tapped"),
                          onSearch: (value) => print("Searching for: $value"),
                        ),

                        SizedBox(height: 20.h),

                        Padding(
                          padding:  EdgeInsets.all(8.w),
                          child: Container(
                            height: 20.h,
                            width: double.infinity,
                            decoration: BoxDecoration(color: AppTheme.primary),
                            child: Center(
                              child: Text(
                                "Free delivery for all orders ",
                                style: AppTheme.bodySmall?.copyWith(
                                  color: AppTheme.background,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 20.0,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SimpleChoiceChips(
                                  options: const [
                                    ChipData('All'),
                                    ChipData('Meals', Icons.set_meal_outlined),
                                    ChipData('Dinner', Icons.fastfood_sharp),
                                    ChipData(
                                      'Drinks',
                                      Icons.emoji_food_beverage_outlined,
                                    ),
                                    ChipData('Fast Foods'),
                                    ChipData('Meat'),
                                  ],
                                  initialSelection: selectedCategories,
                                  onChanged: (values) {
                                    setState(() {
                                      selectedCategories = values;
                                      // If no categories selected, default to 'All'
                                      if (selectedCategories.isEmpty) {
                                        selectedCategories = ['All'];
                                      }
                                      // If 'All' is selected with others, keep only 'All'
                                      if (selectedCategories.contains('All') &&
                                          selectedCategories.length > 1) {
                                        selectedCategories = ['All'];
                                      }
                                    });
                                    print(
                                      "Selected categories: $selectedCategories",
                                    );
                                  },
                                  selectedStyle: ChipStyle(
                                    backgroundColor: AppTheme.primary,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    iconColor: Colors.white,
                                    iconSize: 20,
                                  ),
                                  unselectedStyle: ChipStyle(
                                    backgroundColor: Colors.grey.shade200,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    iconColor: Colors.grey,
                                    iconSize: 20,
                                  ),
                                  multiSelect: true,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Hot Deals Section
                        if (filteredHotDeals.isNotEmpty) ...[
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Hot Deals",
                                      style: AppTheme.bodySmall,
                                    ),
                                    // if (!selectedCategories.contains('All'))
                                    //   Text(
                                    //     "${selectedCategories.join(', ')} Deals",
                                    //     style: AppTheme.bodySmall?.copyWith(
                                    //       color: AppTheme.primary,
                                    //       fontSize: 12.sp,
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              HorizontalFoodCardsWidget(
                                foodItems: filteredHotDeals,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],

                        // Most Bought Section
                        if (filteredMostBought.isNotEmpty) ...[
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Most bought 🔥",
                                      style: AppTheme.bodyMedium,
                                    ),
                                    // if (!selectedCategories.contains('All'))
                                    //   Text(
                                    //     "in ${selectedCategories.join(', ')}",
                                    //     style: AppTheme.bodySmall?.copyWith(
                                    //       color: AppTheme.primary,
                                    //       fontSize: 12.sp,
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              EnhancedFoodCardsWidget(
                                foodItems: filteredMostBought,
                                cardWidth: 190.0,
                                cardHeight: 240.0,
                                spacing: 14.0,
                                showCurrency: true,
                                currencySymbol: '\$',
                                onCardTap: (item) {
                                  print(
                                    "Most bought item tapped: ${item.name}",
                                  );
                                },
                              ),
                            ],
                          ),
                        ],

                        // Empty state when no items found
                        if (filteredHotDeals.isEmpty &&
                            filteredMostBought.isEmpty &&
                            !selectedCategories.contains('All')) ...[
                          Container(
                            padding: EdgeInsets.all(40.w),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 60.sp,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'No items found in ${selectedCategories.join(', ')}',
                                  style: AppTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Try selecting "All" or different categories',
                                  style: AppTheme.bodySmall?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
