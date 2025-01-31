import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AppConst {
  static const appScreenHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 20);
  // ignore: constant_identifier_names
  static const DashboardScreensHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 10);

  static var storage = GetStorage();
  static var isLogged = 'isLogged';
}
