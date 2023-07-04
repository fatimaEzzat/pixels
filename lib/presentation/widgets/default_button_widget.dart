import 'dart:core';

import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';

class DefaultButtonWidget extends StatelessWidget {
  final double width;
  final Color background;
  final bool isUpperCase;
  final double radius;
  final bool disable;
  final bool isBorder;
  final VoidCallback function;
  final String text;
  final double? customHeight;
  final TextStyle? customTextStyle;

  const DefaultButtonWidget(
      {Key? key,
        this.width = double.infinity,
        this.background = defaultColor,
        this.isBorder=false,
        this.isUpperCase = true,
        this.radius = 0.0,
        required this.function,
        required this.text, this.disable = false,this.customHeight,this.customTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: customHeight,
      decoration: BoxDecoration(
        color: background,
        border: isBorder ? Border.all(
          color: Colors.white,
          width: 1.5,
        ) : null,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        onPressed: disable ? null : function,
        child: Text(
          /*isUpperCase ? text.toUpperCase() : text.toLowerCase(),*/ text,
          style: customTextStyle ?? const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
