import 'package:flutter/material.dart';

class CategoryTabs extends StatefulWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CategoryTabs({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.borderRadius = 8.0,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 16.0),
      padding: widget.padding ?? EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: widget.unselectedColor ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        children: _buildCategoryButtons(),
      ),
    );
  }

  List<Widget> _buildCategoryButtons() {
    return widget.categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final isSelected = index == widget.selectedIndex;

      return Expanded(
        flex: 1, // Equal width for all categories
        child: GestureDetector(
          onTap: () => widget.onCategorySelected(index),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? (widget.selectedColor ?? Colors.blue)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(widget.borderRadius - 2),
            ),
            child: Text(
              category,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected
                    ? (widget.selectedTextColor ?? Colors.white)
                    : (widget.unselectedTextColor ?? Colors.grey[700]),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

//