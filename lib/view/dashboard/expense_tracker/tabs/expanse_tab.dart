import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/widget/expanse_tracker_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpanseTab extends StatelessWidget {
  const ExpanseTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                0.verticalSpace(context),
                ExpanseByDateRange(),
                0.verticalSpace(context),
                ExpanseChartWidget(),
                0.verticalSpace(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTextWidget(
                      text: AppConstantStrings.allExpensesTitle,
                      size: 16,
                    ),
                    AppTextWidget(
                      text: AppConstantStrings.seeAll,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                ExpanseTile(
                  icon: Icons.fastfood_outlined,
                  title: 'Food',
                  amount: '20,000',
                  trail: '12 %',
                ),
                ExpanseTile(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Shopping',
                  amount: '80,000',
                  color: const Color.fromARGB(255, 161, 227, 207),
                  trail: '12 %',
                ),
                ExpanseTile(
                  icon: Icons.receipt_long_rounded,
                  title: 'Bill Payments',
                  amount: '1,860',
                  color: const Color.fromARGB(255, 185, 139, 244),
                  trail: '12 %',
                ),
                ExpanseTile(
                  icon: Icons.local_gas_station_outlined,
                  title: 'Fuel',
                  amount: '80,000',
                  color: const Color.fromARGB(255, 227, 161, 161),
                  trail: '12 %',
                ),
                ExpanseTile(
                  icon: Icons.payments_outlined,
                  title: 'EMI',
                  amount: '1,000',
                  color: const Color.fromARGB(255, 161, 197, 244),
                  trail: '12 %',
                ),
                20.verticalSpace(context),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                MoneyKeyboardBottomSheet(
                  isExpanseSheet: true,
                  title: AppConstantStrings.expenses,
                ),
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
