import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_screen_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                0.verticalSpace(context),
                ExpanseByDateRange(),
                0.verticalSpace(context),
                ExpanseChartWidget(),
                0.verticalSpace(context),
                AppTextWidget(
                  text: AppConstantStrings.allExpensesTitle,
                  size: 16,
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
                10.verticalSpace(context),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 0.2),
                    color: AppColor.kMainContainerColor,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: CustomExpansionTile(
                      leading: AppTextWidget(text: '📉'),
                      title: AppConstantStrings.seeAll,
                      children: [
                        ExpanseSmallTile(
                          icon: Icons.fastfood_outlined,
                          amount: '12,000',
                          comment: 'for Biriyani',
                          trail: '12-01-24',
                        ),
                        10.verticalSpace(context),
                        ExpanseSmallTile(
                          icon: Icons.shopping_bag_outlined,
                          amount: '80,000',
                          color: const Color.fromARGB(255, 161, 227, 207),
                          trail: '43-09-90',
                          comment: 'for Biriyani',
                        ),
                        10.verticalSpace(context),
                        ExpanseSmallTile(
                          icon: Icons.receipt_long_rounded,
                          amount: '1,860',
                          color: const Color.fromARGB(255, 185, 139, 244),
                          comment: 'for Biriyani',
                          trail: '12-01-24',
                        ),
                        10.verticalSpace(context),
                        ExpanseSmallTile(
                          icon: Icons.payments_outlined,
                          color: const Color.fromARGB(255, 161, 197, 244),
                          amount: '12,000',
                          comment: 'for Biriyani',
                          trail: '12-01-24',
                        ),
                        10.verticalSpace(context),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 0.2),
                              color: AppColor.kMainContainerColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: CustomExpansionTile(
                              leading: AppTextWidget(text: '📆'),
                              title: '30-01-25',
                              children: [
                                ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return 10.verticalSpace(context);
                                  },
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ExpanseSmallTile(
                                      icon: Icons.fastfood_outlined,
                                      amount: '12,000',
                                      comment: 'for Biriyani',
                                      trail: '12-01-24',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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

// ignore: must_be_immutable
class ExpanseSmallTile extends StatelessWidget {
  ExpanseSmallTile({
    super.key,
    required this.icon,
    required this.comment,
    required this.amount,
    this.color,
    required this.trail,
  });
  final IconData icon;
  final String comment;
  final String amount;
  final String trail;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color ?? const Color.fromARGB(255, 214, 227, 161),
          child: Icon(
            icon,
            color: AppColor.kInvertedTextColor,
            size: 18,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppTextWidget(
                  text: AppConstantStrings.rupees,
                  size: 12,
                  weight: FontWeight.w500,
                ),
                AppTextWidget(
                  text: amount,
                  size: 15,
                  weight: FontWeight.w700,
                ),
              ],
            ),
            AppTextWidget(
              text: comment,
              size: 13,
            ),
          ],
        ),
        Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: AppTextWidget(
            text: trail,
            size: 13,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
