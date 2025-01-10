import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
