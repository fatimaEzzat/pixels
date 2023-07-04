import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/style/colors.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Color bgColor;
  final String hint;

  final bool isDense;
  final bool isPassword;
  final int? maxLength;

  final FormFieldValidator<String> validator;
  final String label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? suffixIconPressed;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  bool isClickable;

  DefaultTextFormField(
      {Key? key,
        required this.controller,
        required this.textInputType,
        required this.validator,
        required this.label,
        this.prefixIcon,
        this.suffixIcon,
        this.suffixIconPressed,
        this.isPassword = false,
        this.isClickable = true,
        this.hint = '',
        this.onTap,
        this.isDense = true,
        this.bgColor = Colors.white54, this.focusNode, this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const InputDecorationTheme defaultTheme = InputDecorationTheme();

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        counterText: '',
        fillColor: bgColor,
        hintText: hint,
        labelText: label,
        labelStyle:  TextStyle(color: Colors.black),
        //hintText
        prefixIcon: prefixIcon!=null ? Icon(
          prefixIcon,
          color:  Colors.black,
        ) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: suffixIcon!,
          onPressed: suffixIcon != null ? suffixIconPressed : null,
        )
            : null,
        enabledBorder: isDense
            ?  OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(25.0),
        )
            : defaultTheme.enabledBorder,
        border: OutlineInputBorder(
          borderRadius: isDense
              ? BorderRadius.circular(25.0)
              : BorderRadius.circular(5.0),
        ),
        isDense: isDense,
        // Added this
        contentPadding: isDense
            ? const EdgeInsets.all(8)
            : defaultTheme.contentPadding, // Added this
      ),
      validator: validator,
      keyboardType: textInputType,
      obscureText: isPassword,
      onTap: onTap,
      enabled: isClickable,
    );
  }
}
