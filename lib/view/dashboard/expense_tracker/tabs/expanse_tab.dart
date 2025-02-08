import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/category/category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_screen_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    text: AppConstantStrings.allExpensesTitle, size: 16),
                // 10.verticalSpace(context),
                BlocConsumer<ExpenseByCategoryBloc, ExpenseByCategoryState>(
                  listener: (context, state) {
                    if (state is ExpenseByCategoryError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)));
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
                          final entry = categoryExpense[index];
                          return ExpanseTile(
                            category: entry['category'],
                            amount: '${entry['total']}',
                            trail: '12 %',
                          );
                        },
                      );
                    }
                    return Center(child: Text("No income data available."));
                  },
                ),
                10.verticalSpace(context),
                BlocConsumer<ExpenseByDateBloc, ExpenseByDateState>(
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
                      return Center(
                          child: Text("Error: ${state.errorMessage}"));
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
                            separatorBuilder: (context, index) =>
                                10.verticalSpace(context),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: groupedData.length,
                            itemBuilder: (context, index) {
                              final incomeList = groupedData[index];
                              final todayDate =
                                  AppDateFormates.barFormattedDate(
                                      DateTime.now());
                              final incomeDate =
                                  AppDateFormates.barFormattedDate(
                                      incomeList.first.createdAt!);

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
                                    title: todayDate == incomeDate
                                        ? AppConstantStrings.today
                                        : incomeDate,
                                    children: [
                                      ...incomeList.map(
                                        (income) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: ExpanseSmallTile(
                                              category: income.category,
                                              comment: income.comment,
                                              amount:
                                                  '${income.currency} ${income.amount}',
                                              payMethode: income.paymentMethode,
                                              trail: AppDateFormates
                                                  .normalFormatTime(
                                                      income.createdAt!),
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

                    return Center(
                        child: Text("No data available for this month."));
                  },
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
                  isIncomeSheet: false,
                  isExpanseSheet: true,
                  title: AppConstantStrings.income,
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
