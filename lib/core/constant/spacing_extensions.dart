import 'package:flutter/material.dart';

extension SpacingExtensions on num {
  Widget verticalSpace(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * (this / 1000));
  Widget horizontalSpace(BuildContext context) =>
      SizedBox(width: MediaQuery.of(context).size.width * (this / 1000));
}
