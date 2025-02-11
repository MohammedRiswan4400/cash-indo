import 'dart:developer';

import 'package:cash_indo/controller/db/expense_db/expense_db.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/auth/sign_up/screen_sign_up.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/category/category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/highest_expense/highest_expense_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/weekly_chart/weekly_expense_chart_bloc.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/view/dashboard/home/widgets/home_screen_widgets.dart';
import 'package:cash_indo/widget/dialoge_boxes.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
// Tab One +++++++++++++++++++++++++++++++++++++++++++++++++++++

// First Widget ----------------------------------------

class ExpanseByDateRange extends StatelessWidget {
  const ExpanseByDateRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.kExpanseByDateRangeContainerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ExpanceTitleAndAmount(
              title: 'Day',
              amount: AppFormats.moneyFormat('689000'),
            ),
            AppTextWidget(
              text: '|',
              size: 15,
              weight: FontWeight.w500,
              color: AppColor.kTextColor,
            ),
            ExpanceTitleAndAmount(
              title: 'Week',
              amount: AppFormats.moneyFormat('69000'),
            ),
            AppTextWidget(
              text: '|',
              size: 15,
              weight: FontWeight.w500,
              color: AppColor.kTextColor,
            ),
            FutureBuilder<double>(
              future: ExpenseDb.getMonthlyExpenseTotal(
                  "February"), // Pass current month
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading state
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error loading data")); // Error state
                } else {
                  double expense = snapshot.data ?? 0.0;
                  return ExpanceTitleAndAmount(
                    title: 'Month',
                    amount:
                        '${AppFormats.moneyFormat(expense.toStringAsFixed(0))}',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Second Widget ----------------------------------------

class ExpanseChartWidget extends StatelessWidget {
  const ExpanseChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeeklyExpenseChartBloc, WeeklyExpenseChartState>(
      listener: (context, state) {
        if (state is WeeklyExpenseChartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is WeeklyExpenseChartLoading) {
          return Center(child: CircularProgressIndicator());
        }

        List<BarChartGroupData> barChartData = [];
        // double? maxYValue;
        if (state is WeeklyExpenseChartLoaded) {
          barChartData = state.chartData;
          log('ssssssss');
          return ExpenseBarGraphWidget(
            barChartData: barChartData,
          );
        }

        log('message');
        return ExpenseBarGraphWidget(
          barChartData: barChartData,
        );
      },
    );
  }
}

// Third widgets ----------------------------------------

class ExpenseCategoryWidget extends StatelessWidget {
  const ExpenseCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseByCategoryBloc, ExpenseByCategoryState>(
      listener: (context, state) {
        if (state is ExpenseByCategoryError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is ExpenseByCategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ExpenseByCategoryLoaded) {
          final categoryExpense = state.categoryExpenseByCategory;
          if (categoryExpense.isEmpty) {
            return Text("No expense data available.");
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return 10.verticalSpace(context);
            },
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryExpense.length,
            itemBuilder: (context, index) {
              final totalSum = categoryExpense.fold(0.0,
                  (sum, item) => sum + (item['total'] as num)); // Total sum
              final entry = categoryExpense[index];
              final double entryTotal = entry['total'] as double;
              final double percentage =
                  totalSum > 0 ? (entryTotal / totalSum) * 100 : 0.0;

              return ExpanseTile(
                category: entry['category'],
                amount: '${entry['total']}',
                trail: '${percentage.toStringAsFixed(0)}%',
              );
            },
          );
        }
        return Center(child: Text("No expense data available."));
      },
    );
  }
}

// Fourth Widget --------------------------------------------------

class DailyExpenseListTile extends StatelessWidget {
  const DailyExpenseListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseByDateBloc, ExpenseByDateState>(
      listener: (context, state) {
        if (state is ExpenseByDateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is ExpenseByDateLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ExpenseByDateError) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }

        if (state is ExpenseByDateLoaded) {
          final groupedData = state.groupedData;

          return Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  AppTextWidget(text: '📉'),
                  AppTextWidget(
                    text: AppConstantStrings.seeAll,
                    size: 16,
                  ),
                ],
              ),
              10.verticalSpace(context),
              ListView.separated(
                reverse: true,
                separatorBuilder: (context, index) => 10.verticalSpace(context),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: groupedData.length,
                itemBuilder: (context, index) {
                  final expenseList = groupedData[index];
                  final todayDate = AppFormats.barFormattedDate(DateTime.now());
                  final expenseDate =
                      AppFormats.barFormattedDate(expenseList.first.createdAt!);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.2),
                      color: AppColor.kMainContainerColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: CustomExpansionTile(
                        leading: AppTextWidget(text: '📆'),
                        title: todayDate == expenseDate
                            ? AppConstantStrings.today
                            : expenseDate,
                        children: [
                          ...expenseList.map(
                            (expense) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: ExpanseSmallTile(
                                  id: expense.id!,
                                  category: expense.category,
                                  comment: expense.comment,
                                  amount:
                                      '${expense.currency} ${AppFormats.moneyFormat(expense.amount.toString())}',
                                  payMethode: expense.paymentMethode,
                                  trail: AppFormats.normalFormatTime(
                                    expense.createdAt!,
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
              ),
            ],
          );
        }

        return Center(child: Text("No data available for this month."));
      },
    );
  }
}

// sub widgets

class ExpanceTitleAndAmount extends StatelessWidget {
  const ExpanceTitleAndAmount({
    super.key,
    required this.title,
    required this.amount,
  });
  final String title;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 4,
      child: Column(
        spacing: 8,
        children: [
          AppTextWidget(
            text: title,
            size: 15,
            weight: FontWeight.w800,
            color: AppColor.kTextColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              AppTextWidget(
                text: AppConstantStrings.rupees,
                size: 17,
                color: AppColor.kTextColor,
              ),
              AppTextAutoSize(
                text: amount,
                size: 17,
                maxLine: 1,
                color: AppColor.kTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ExpenseBarGraphWidget extends StatelessWidget {
  ExpenseBarGraphWidget({
    super.key,
    required this.barChartData,
    // required this.maxYValue,
  });

  final List<BarChartGroupData> barChartData;
  double? maxYValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<HighestExpenseBloc, HighestExpenseState>(
          listener: (context, state) {
            if (state is HighestExpenseError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is HighestExpenseLoading) {
              return Center(child: CircularProgressIndicator());
            }

            // ignore: unused_local_variable
            double highestSpendingAmount = 0.0;
// Default maxY

            if (state is HighestWeeklyExpensesLoaded) {
              highestSpendingAmount = state.highestAmount;
            }

            return SizedBox();
          },
        ),
        if (barChartData.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.kContainerColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 4, left: 4, right: 4, top: 10),
              child: Column(
                spacing: 5,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextWidget(
                        text: 'Weekly Tracker',
                        size: 17,
                        weight: FontWeight.w600,
                        color: AppColor.kInvertedTextColor,
                      ),
                      Row(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          legendWidgets(
                            color: Colors.green,
                            text: AppConstantStrings.week,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    height: 220,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BarChart(
                        curve: Curves.easeInOut,
                        transformationConfig: FlTransformationConfig(
                          panEnabled: false,
                          scaleEnabled: false,
                        ),
                        BarChartData(
                          extraLinesData:
                              ExtraLinesData(extraLinesOnTop: false),
                          backgroundColor: const Color.fromARGB(255, 4, 51, 42),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              // axisNameWidget: Container(
                              //   color: const Color.fromARGB(0, 255, 193, 7),
                              //   height: 100,
                              // ),
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipRoundedRadius: 100,
                              fitInsideVertically: true,
                              // tooltipMargin: 10,
                            ),
                          ),
                          maxY: maxYValue,
                          barGroups: expanseTrackerChartGroupes(barChartData),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: AppConstantStrings.allWeeks.map((day) {
                      return AppTextWidget(
                        text: day,
                        size: 11,
                        weight: FontWeight.w600,
                        color: AppColor.kInvertedTextColor,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// Sub Widget
List<BarChartGroupData> expanseTrackerChartGroupes(
    List<BarChartGroupData> data) {
  return List.generate(
    data.length,
    (index) {
      final BarChartGroupData barData = data[index];
      return BarChartGroupData(
        x: barData.x,
        barRods: [
          BarChartRodData(
            toY: barData.barRods.first.toY,
            color: Colors.green,
            width: 25,
            backDrawRodData: BackgroundBarChartRodData(
              toY: barData.barRods.first.toY,
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ],
      );
    },
  );
}

// ignore: must_be_immutable
class ExpanseSmallTile extends StatelessWidget {
  ExpanseSmallTile({
    super.key,
    required this.payMethode,
    required this.amount,
    this.color,
    required this.comment,
    required this.trail,
    required this.category,
    required this.id,
  });
  final String payMethode;
  final String amount;
  final String trail;
  final String comment;
  final String category;
  Color? color;
  final int id;

  @override
  Widget build(BuildContext context) {
    final categoryData = getCategoryIconAndColor(category);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.2),
        color: AppColor.kMainContainerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: CustomExpansionTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: categoryData['color'] ??
                const Color.fromARGB(255, 214, 227, 161),
            child: Icon(
              categoryData['icon'],
              color: AppColor.kInvertedTextColor,
              size: 18,
            ),
          ),
          title: amount,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  comment != ''
                      ? Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.3,
                              child: AppTextWidget(
                                text: comment,
                                align: TextAlign.start,
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Divider(
                              color: AppColor.kArrowColor,
                            )
                          ],
                        )
                      : SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 20,
                    children: [
                      AppTextWidget(
                        text: category,
                        size: 15,
                        weight: FontWeight.w700,
                      ),
                      AppTextWidget(
                        text: payMethode,
                        size: 13,
                      ),
                      // Spacer(),
                      AppTextWidget(
                        text: trail,
                        size: 13,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  10.verticalSpace(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.dialog(Dialog(
                              backgroundColor: Colors.black,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: DeleteDialogeBox(
                                deleteWhat: 'Expense',
                                ontap: () {
                                  ExpenseDb.deleteExpense(
                                    context,
                                    //Issue here ------------------------------------------------------------------------------------------------------------------------
                                    AppFormats.monthFormattedDate(
                                        DateTime.now()),
                                    id,
                                  );
                                },
                              )));
                        },
                        child: smallButton(
                          isDelete: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class smallButton extends StatelessWidget {
  const smallButton({
    super.key,
    required this.isDelete,
  });
  final bool isDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isDelete ? Colors.redAccent : Colors.green),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Row(
            spacing: 4,
            children: [
              AppTextWidget(
                // weight: FontWeight.normal,
                text: isDelete ? 'Delete' : 'Edit',
                size: 12,
              ),
            ],
          ),
        ));
  }
}

// Currency Selector ------------------------------------

// ignore: must_be_immutable
class ExpanseTile extends StatelessWidget {
  const ExpanseTile({
    super.key,
    required this.amount,
    required this.trail,
    required this.category,
  });
  final String amount;
  final String trail;
  final String category;
  @override
  Widget build(BuildContext context) {
    final categoryData = getCategoryIconAndColor(category);
    return Row(
      spacing: 20,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: categoryData['color'],
          child: Icon(categoryData['icon'], color: AppColor.kInvertedTextColor),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget(
              text: category,
              size: 15,
            ),
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
                  text: AppFormats.moneyFormat(amount).toString(),
                  size: 13,
                  weight: FontWeight.w700,
                ),
              ],
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

// Tab Two +++++++++++++++++++++++++++++++++++++++++++++++++++++

// First Widget ----------------------------------------

Map<String, dynamic> getCategoryIconAndColor(String category) {
  switch (category) {
    case 'Food':
      return {
        'icon': Icons.fastfood_outlined,
        'color': const Color.fromARGB(255, 214, 227, 161)
      };
    case 'Shopping':
      return {
        'icon': Icons.shopping_bag_outlined,
        'color': const Color.fromARGB(255, 161, 227, 207)
      };
    case 'Bill Payments':
      return {
        'icon': Icons.receipt_long_rounded,
        'color': const Color.fromARGB(255, 148, 139, 244),
      };
    case 'Travel':
      return {
        'icon': Icons.local_gas_station_outlined,
        'color':
            //  const Color.fromARGB(255, 251, 91, 51)
            const Color.fromARGB(255, 227, 161, 161)
      };
    case 'EMI':
      return {
        'icon': Icons.payments_outlined,
        'color': const Color.fromARGB(255, 161, 197, 244)
      };
    default:
      return {
        'icon': Icons.category_outlined,
        'color': const Color.fromARGB(255, 51, 138, 251),
      }; // Default values
  }
}
