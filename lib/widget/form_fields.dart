import 'package:cash_indo/core/color/app_color.dart';
import 'package:flutter/material.dart';

bool isObscure = true;

// ignore: must_be_immutable
class EmailTextFormField extends StatelessWidget {
  EmailTextFormField({
    super.key,
    required this.controller,
    this.action,
    this.type,
  });
  TextInputAction? action;
  TextInputType? type;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      textInputAction: action,
      controller: controller,
      cursorHeight: 20,
      style: TextStyle(
        color: AppColor.kInvertedTextColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        fillColor: AppColor.kContainerColor,
        filled: true,
        hintText: 'Please enter your email here',
        hintStyle:
            const TextStyle(color: AppColor.kInvertedTextColor, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          // borderSide: const BorderSide(
          //   color: AppColor.kInvertedTextColor,
          //   width: 1.0,
          // ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          // borderSide: const BorderSide(color: AppColor.kTextColor),
        ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(7.0),
        //   borderSide: const BorderSide(
        //     color: AppColor.kTextColor,
        //     width: 1.0,
        //   ),
        // ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required*';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  PasswordField({
    super.key,
    required this.passwoedController,
    this.action,
    this.type,
    required this.hintText,
  });
  final TextEditingController passwoedController;
  final String hintText;
  TextInputAction? action;
  TextInputType? type;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.type,
      textInputAction: widget.action,
      controller: widget.passwoedController,
      cursorHeight: 20,
      style: const TextStyle(
        color: AppColor.kInvertedTextColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        fillColor: AppColor.kContainerColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle:
            const TextStyle(color: AppColor.kInvertedTextColor, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: isObscure
              ? const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColor.kInvertedTextColor,
                )
              : const Icon(
                  Icons.visibility_outlined,
                  color: AppColor.kInvertedTextColor,
                ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required*';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
      obscureText: isObscure ? true : false,
    );
  }
}
