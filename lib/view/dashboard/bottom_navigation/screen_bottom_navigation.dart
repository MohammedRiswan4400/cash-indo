import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/view/dashboard/bottom_navigation/screen_navigation.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/screen_expense_tracker.dart';
import 'package:cash_indo/view/dashboard/home/screen_home.dart';
import 'package:cash_indo/view/dashboard/settings/screen_settings.dart';
import 'package:cash_indo/view/dashboard/sheet/screen_balance_sheet.dart';
import 'package:flutter/material.dart';

class ScreenBottonNavigation extends StatelessWidget {
  ScreenBottonNavigation({super.key});

  final _pages = [
    ScreenHome(),
    ScreenExpenseTracker(),
    ScreenBalanceSheet(),
    ScreenSettings()
  ];

  @override
  Widget build(BuildContext context) {
    ExpenseDb.fetchExpense(
      context,
      AppDateFormates.monthFormattedDate(DateTime.now()),
    );
    IncomeDb.fetchIncome(
      context,
      AppDateFormates.monthFormattedDate(DateTime.now()),
    );
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
