import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pin_code_fields/pin_code_fields.dart'; // Optional package

// Method 1: Custom PIN Code Widget (No external package needed)
class SimplePinCodeTextField extends StatefulWidget {
  const SimplePinCodeTextField({
    super.key,
    this.length = 4,
    this.fieldHeight = 70.0,
    this.fieldWidth = 60.0,
    this.borderRadius = 16.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.selectedColor = Colors.blueGrey,
    this.textStyle,
    this.onChanged,
    this.onCompleted,
  });

  final int length;
  final double fieldHeight;
  final double fieldWidth;
  final double borderRadius;
  final Color activeColor;
  final Color inactiveColor;
  final Color selectedColor;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  @override
  State<SimplePinCodeTextField> createState() => _SimplePinCodeTextFieldState();
}

class _SimplePinCodeTextFieldState extends State<SimplePinCodeTextField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  String pinCode = '';

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (index) => TextEditingController());
    focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      // Move to next field if not the last field
      if (index < widget.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        // Last field, unfocus
        FocusScope.of(context).unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      // Move to previous field if current field is empty
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    // Update pin code
    pinCode = controllers.map((controller) => controller.text).join();
    
    // Call onChanged callback
    if (widget.onChanged != null) {
      widget.onChanged!(pinCode);
    }

    // Call onCompleted callback if all fields are filled
    if (pinCode.length == widget.length && widget.onCompleted != null) {
      widget.onCompleted!(pinCode);
    }
  }

  Color _getBorderColor(int index) {
    if (focusNodes[index].hasFocus) {
      return widget.activeColor;
    } else if (controllers[index].text.isNotEmpty) {
      return widget.selectedColor;
    } else {
      return widget.inactiveColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return Container(
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: _getBorderColor(index),
              width: 2.0.w,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Center(
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              style: widget.textStyle ?? TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.zero,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _onChanged(value, index),
              onTap: () {
                // Clear the field when tapped
                controllers[index].clear();
                setState(() {});
              },
            ),
          ),
        );
      }),
    );
  }
}
