import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.margin = const EdgeInsets.only(bottom: 15.0),
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onTap,
  }) : super(key: key);
  final String? hintText;
  final EdgeInsetsGeometry? margin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextField(
        onTap: onTap,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFD6D6D6),
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.2,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
