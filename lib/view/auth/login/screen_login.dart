import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/widget/login_widget.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConst.appScreenHorizontalPadding,
          child: MediaQuery.sizeOf(context).height < 650
              ? WithSingleChildScrolledView()
              : WithoutSingleChildScrolledView(),
        ),
      ),
    );
  }
}
