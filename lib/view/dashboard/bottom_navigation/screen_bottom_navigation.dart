import 'package:cash_indo/view/dashboard/bottom_navigation/screen_navigation.dart';
import 'package:cash_indo/view/dashboard/expenses%20/screen_expenses.dart';
import 'package:cash_indo/view/dashboard/home/screen_home.dart';
import 'package:cash_indo/view/dashboard/settings/screen_settings.dart';
import 'package:cash_indo/view/dashboard/sheet/screen_balance_sheet.dart';
import 'package:flutter/material.dart';

class ScreenBottonNavigation extends StatelessWidget {
  ScreenBottonNavigation({super.key});

  final _pages = [
    ScreenHome(),
    // storage.read(isDummyUser) == true
    //     ? const DummyUserScreen()
    //     : const ScreenBookNow(),
    // storage.read(isDummyUser) == true
    //     ? const DummyUserScreen()
    //     : const ScreenBookings(),
    const ScreenExpenses(),
    const ScreenBalanceSheet(),
    const ScreenSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int index, _) {
          return _pages[index];
        },
      ),
      bottomNavigationBar: const ScreenNavigations(),
    );
  }
}
