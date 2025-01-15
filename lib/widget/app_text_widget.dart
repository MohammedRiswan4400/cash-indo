import 'package:auto_size_text/auto_size_text.dart';
import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// // ignore: must_be_immutable
// class AppTextWidget extends StatelessWidget {
//   AppTextWidget(
//       {super.key,
//       required this.text,
//       this.color,
//       this.size,
//       this.weight,
//       this.maxLine,
//       this.isUnderLine,
//       this.align});
//   final String text;
//   Color? color;
//   double? size;
//   FontWeight? weight;
//   int? maxLine;
//   TextAlign? align;
//   bool? isUnderLine;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       textAlign: align ?? TextAlign.center,
//       text,
//       overflow: TextOverflow.ellipsis,
//       maxLines: maxLine ?? 100,
//       style:
//       TextStyle(
//         decoration: isUnderLine == true
//             ? TextDecoration.underline
//             : TextDecoration.none,
//         decorationColor: color ?? Colors.white,
//         color: color ?? Colors.white,
//         fontSize: size ?? 20,
//         fontWeight: weight ?? FontWeight.bold,

//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class AppTextAutoSize extends StatelessWidget {
  AppTextAutoSize({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.maxLine,
  });

  final String text;
  Color? color;
  double? size;
  int? maxLine;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode.value;
    final themeTextColor = isDarkMode ? color : Colors.black;
    final themeFontSize = size ?? 20.0;
    return AutoSizeText(
      text,
      maxLines: maxLine ?? 100,
      style: TextStyle(
        color: color ?? themeTextColor,
        fontSize: themeFontSize,
      ),
    );
  }
}

// ignore: must_be_immutable
class AppTextWidget extends StatelessWidget {
  AppTextWidget({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.maxLine,
    this.isUnderLine,
    this.align,
  });

  final String text;
  Color? color;
  double? size;
  FontWeight? weight;
  int? maxLine;
  TextAlign? align;
  bool? isUnderLine;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode.value;
    final themeTextColor = isDarkMode ? color : Colors.black;
    final themeFontSize = size ?? 20.0;
    final themeFontWeight = weight ?? FontWeight.bold;

    return Text(
      textAlign: align ?? TextAlign.center,
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine ?? 100,
      style: TextStyle(
        decoration: isUnderLine == true
            ? TextDecoration.underline
            : TextDecoration.none,
        color: color ?? themeTextColor,
        fontSize: themeFontSize,
        fontWeight: themeFontWeight,
      ),
    );
  }
}

// ignore: must_be_immutable
class AppTextWidgetWithGFound extends StatelessWidget {
  AppTextWidgetWithGFound({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.maxLine,
    this.isUnderLine,
    this.align,
  });

  final String text;
  Color? color;
  double? size;
  FontWeight? weight;
  int? maxLine;
  TextAlign? align;
  bool? isUnderLine;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDarkMode = themeController.isDarkMode.value;
    final themeTextColor = isDarkMode ? color : Colors.black;
    final themeFontSize = size ?? 20.0;
    final themeFontWeight = weight ?? FontWeight.bold;

    return Text(
      textAlign: align ?? TextAlign.center,
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine ?? 100,
      style: GoogleFonts.abel(
        textStyle: TextStyle(
          decoration: isUnderLine == true
              ? TextDecoration.underline
              : TextDecoration.none,
          color: color ?? themeTextColor,
          fontSize: themeFontSize,
          fontWeight: themeFontWeight,
        ),
      ),
    );
  }
}
