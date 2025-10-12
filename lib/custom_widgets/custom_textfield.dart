import 'package:flutter/material.dart';

import '../custom_colors/custom_colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool? obsureText;
  final String? Function(String?)? validator;
  final Function? onTap;
  final bool? readOnly;
  final Widget? preFixIcon;
  final Widget? sufFixIcon;
  final TextInputAction? inputAction;
  final String? labelText;
  final EdgeInsets? contentPadding;
  final String? initialValue;
  final int? maxLine;

  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.hintText,
    this.maxLength,
    this.obsureText,
    this.validator,
    this.readOnly,
    this.preFixIcon,
    this.sufFixIcon,
    this.onTap,
    this.labelText,
    this.inputAction,
    this.maxLine,
    this.contentPadding,
    this.initialValue,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: CustomColors.primaryColor,
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxLine,
      readOnly: readOnly ?? false,
      obscureText: obsureText ?? false,
      textInputAction: inputAction,
      onTap: () {
        if ((readOnly ?? false) && onTap != null) {
          onTap!();
        }
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: CustomColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black87),
        ),
        border: OutlineInputBorder(),
        prefixIcon: preFixIcon,
        suffixIcon: sufFixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: CustomColors.blackColor),
        floatingLabelStyle: TextStyle(color: CustomColors.primaryColor),
        hintStyle: TextStyle(color: CustomColors.blackColor),
        contentPadding: contentPadding,
        counterText: "",
      ),
    );
  }
}