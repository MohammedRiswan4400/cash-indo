import 'dart:developer';

import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/category/by_category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/monthly_total/income_monthly_total_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/widget/helper/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MonthlyTotalWidget extends StatelessWidget {
  const MonthlyTotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeMonthlyTotalBloc, IncomeMonthlyTotalState>(
      listener: (context, state) {
        if (state is IncomeMonthlyTotalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is IncomeMonthlyTotalLoading) {
          return ShimmerErrorWidget(
              firstWidth: 100,
              isColumn: false,
              firstHeight: 50,
              secondWidth: double.infinity,
              secondHeight: 40);
        } else if (state is IncomeMonthlyTotalLoaded) {
          double totalIncome = state.totalMonthlyIncome;
          log(totalIncome.toString());
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: AppTextWidget(
                  text: AppConstantStrings.rupees,
                  size: 18,
                  color: AppColor.kArrowColor,
                ),
              ),
              AppTextWidget(
                text: AppFormats.moneyFormat(totalIncome.toString()),
                color: AppColor.kArrowColor,
                size: 30,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppTextWidget(
                text: AppConstantStrings.rupees,
                size: 18,
                color: AppColor.kArrowColor,
              ),
            ),
            AppTextWidget(
              text: '000.00',
              color: AppColor.kArrowColor,
              size: 30,
            ),
          ],
        );
      },
    );
  }
}

class CategoryTotalWidget extends StatelessWidget {
  const CategoryTotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeByCategoryBloc, IncomeByCategoryState>(
      listener: (context, state) {
        if (state is IncomeByCategoryError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is IncomeByCategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is IncomeByCategoryLoaded) {
          final categoryIncome = state.categoryIncomeByCategory;
          if (categoryIncome.isEmpty) {
            return Text("No income data available.");
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryIncome.length,
            itemBuilder: (context, index) {
              final totalSum = categoryIncome.fold(
                  0.0, (sum, item) => sum + (item['total'] as num));
              final entry = categoryIncome[index];
              final double entryTotal = entry['total'] as double;
              final double percentage =
                  totalSum > 0 ? (entryTotal / totalSum) * 100 : 0.0;

              return IncomeProgressBarWidget(
                title: entry['category'],
                amount: entryTotal.toStringAsFixed(2),
                percentage: percentage,
              );
            },
          );
        }
        return Center(child: Text("No income data available."));
      },
    );
  }
}

class DailyIncomeListTileWidget extends StatelessWidget {
  const DailyIncomeListTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomeByDateBloc, IncomeByDateState>(
      listener: (context, state) {
        if (state is IncomeByDateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is IncomeByDateLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is IncomeByDateError) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }

        if (state is IncomeByDateLoaded) {
          final groupedData = state.groupedData;

          return ListView.separated(
            reverse: true,
            separatorBuilder: (context, index) => 10.verticalSpace(context),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: groupedData.length,
            itemBuilder: (context, index) {
              final incomeList = groupedData[index];
              final todayDate = AppFormats.barFormattedDate(DateTime.now());
              final incomeDate =
                  AppFormats.barFormattedDate(incomeList.first.createdAt!);

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 0.2),
                  color: AppColor.kMainContainerColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: CustomExpansionTile(
                    leading: AppTextWidget(text: '📆'),
                    title: todayDate == incomeDate
                        ? AppConstantStrings.today
                        : incomeDate,
                    children: [
                      ...incomeList.map(
                        (income) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColor.kArrowColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Column(
                                spacing: 10,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppTextWidget(
                                        // ${AppConstantStrings.rupees}
                                        text:
                                            '${income.currency} ${AppFormats.moneyFormat(income.amount.toString())}',
                                        size: 16,
                                        weight: FontWeight.w600,
                                        align: TextAlign.start,
                                      ),
                                      AppTextWidget(
                                        text: income.category,
                                        size: 15,
                                        color: const Color.fromARGB(
                                            255, 139, 139, 139),
                                        weight: FontWeight.w500,
                                        align: TextAlign.start,
                                      ),
                                      AppTextWidget(
                                        text: AppFormats.normalFormatTime(
                                            income.createdAt!),
                                        size: 15,
                                        color: AppColor.kArrowColor,
                                        weight: FontWeight.w500,
                                        align: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        // color: Colors.amber,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                2,
                                        child: AppTextWidget(
                                          text: income.comment,
                                          size: 15,
                                          color: const Color.fromARGB(
                                              255, 139, 139, 139),
                                          weight: FontWeight.w500,
                                          align: TextAlign.start,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(Dialog(
                                              backgroundColor: Colors.black,
                                              shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: DeleteDialogeBox(
                                                deleteWhat: 'Income',
                                                ontap: () {
                                                  IncomeDb.deleteIncome(
                                                    context,
                                                    //Issue here ------------------------------------------------------------------------------------------------------------------------
                                                    AppFormats
                                                        .monthFormattedDate(
                                                            income.createdAt!),
                                                    income.id!,
                                                  );
                                                },
                                              )));
                                          // IncomeDb
                                          //     .deleteIncome(
                                          //   context,
                                          //   AppFormats
                                          //       .monthFormattedDate(
                                          //           DateTime
                                          //               .now()),
                                          //   income.id!,
                                          // );
                                        },
                                        child: smallButton(
                                          isDelete: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return Center(child: Text("No data available for this month."));
      },
    );
  }
}

///Sub Widgets

class IncomeProgressBarWidget extends StatelessWidget {
  const IncomeProgressBarWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
  });
  final String title;
  final String amount;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextWidget(
              text: title,
              size: 16,
              weight: FontWeight.w600,
            ),
            AppTextWidget(
              text: '${percentage.toStringAsFixed(2)}%',
              size: 12,
              color: AppColor.kArrowColor,
              weight: FontWeight.w600,
            ),
          ],
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: themeController.isDarkMode.value
                ? AppColor.kContainerColor
                : AppColor.kHomeCreditContainerColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: (MediaQuery.sizeOf(context).width / 1.0) *
                    (percentage / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeController.isDarkMode.value
                      ? AppColor.kHomeCreditContainerColor
                      : AppColor.kContainerColor,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AppTextWidget(
            text:
                '${AppConstantStrings.rupees} ${AppFormats.moneyFormat(amount).toString()}',
            size: 14,
            weight: FontWeight.w600,
            align: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
