import 'package:flutter/material.dart';

class ChipData {
  const ChipData(this.label, [this.iconData]);
  final String label;
  final IconData? iconData; // Now uses Flutter's built-in icons
}

class ChipStyle {
  const ChipStyle({
    this.backgroundColor,
    this.textStyle,
    this.iconColor,
    this.iconSize,
    this.labelPadding,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
  });

  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? labelPadding;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
}

class SimpleChoiceChips extends StatefulWidget {
  final List<ChipData> options;
  final List<String> initialSelection;
  final void Function(List<String>) onChanged;
  final ChipStyle selectedStyle;
  final ChipStyle unselectedStyle;
  final bool multiSelect;
  final bool scrollable;
  final double spacing;
  final double runSpacing;

  const SimpleChoiceChips({
    super.key,
    required this.options,
    required this.initialSelection,
    required this.onChanged,
    required this.selectedStyle,
    required this.unselectedStyle,
    this.multiSelect = false, // Default is single selection
    this.scrollable = false,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
  });

  @override
  State<SimpleChoiceChips> createState() => _SimpleChoiceChipsState();
}

class _SimpleChoiceChipsState extends State<SimpleChoiceChips> {
  late List<String> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.initialSelection);
    
    // Ensure only one item is selected if multiSelect is false
    if (!widget.multiSelect && selected.length > 1) {
      selected = selected.take(1).toList();
    }
  }

  void _onChipTapped(String label) {
    setState(() {
      if (widget.multiSelect) {
        // Multi-select behavior
        selected.contains(label) ? selected.remove(label) : selected.add(label);
      } else {
        // Single select behavior - always replace with new selection
        if (selected.contains(label)) {
          // If clicking the same chip, you can either:
          // Option 1: Keep it selected (current behavior)
          selected = [label];
          // Option 2: Deselect it (uncomment below line)
          // selected = [];
        } else {
          // Select new chip and deselect others
          selected = [label];
        }
      }
    });
    widget.onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.options.map((chip) {
      final isSelected = selected.contains(chip.label);
      final style = isSelected ? widget.selectedStyle : widget.unselectedStyle;

      return ChoiceChip(
        label: Text(
          chip.label,
          style: style.textStyle,
          overflow: TextOverflow.ellipsis,
        ),
        avatar: chip.iconData != null
            ? Icon(chip.iconData, size: style.iconSize, color: style.iconColor)
            : null,
        selected: isSelected,
        onSelected: (_) => _onChipTapped(chip.label),
        backgroundColor: style.backgroundColor,
        selectedColor: widget.selectedStyle.backgroundColor,
        elevation: style.elevation ?? 0,
        labelPadding: style.labelPadding,
        showCheckmark: false, // This removes the tick symbol
        shape: RoundedRectangleBorder(
          borderRadius: style.borderRadius ?? BorderRadius.circular(16),
          side: BorderSide(
            color: style.borderColor ?? Colors.transparent,
            width: style.borderWidth ?? 0,
          ),
        ),
      );
    }).toList();

    return widget.scrollable
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: children.map((chip) => Padding(
                padding: EdgeInsets.only(right: widget.spacing),
                child: chip,
              )).toList(),
            ),
          )
        : Wrap(
            spacing: widget.spacing,
            runSpacing: widget.runSpacing,
            children: children,
          );
  }
}