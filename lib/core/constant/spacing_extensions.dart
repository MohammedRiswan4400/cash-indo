import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension SpacingExtensions on num {
  Widget get verticalSpace => SizedBox(height: Get.height * (this / 1000));
  Widget get horizontalSpace => SizedBox(width: Get.width * (this / 1000));
}
