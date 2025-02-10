import 'dart:developer';
import 'package:cash_indo/controller/db/income_db/income_db.dart';
import 'package:cash_indo/controller/functions/date_and_time/date_and_time_formates.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/category/by_category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/monthly_total/income_monthly_total_bloc.dart';

import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/bottom_sheets.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/widgets/expanse_tracker_screen_widgets.dart';
import 'package:cash_indo/widget/drop_down_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:cash_indo/widget/helper/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../widget/dialoge_boxes.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // isListExpanded.value = false;
    return Stack(
      children: [
        SizedBox(
          child: ValueListenableBuilder(
              valueListenable: selectedMonthNotifier,
              builder: (context, selectedMonth, _) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: '$selectedMonth Income',
                        color: AppColor.kArrowColor,
                      ),
                      BlocConsumer<IncomeMonthlyTotalBloc,
                          IncomeMonthlyTotalState>(
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
                                  text: totalIncome.toString(),
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
                      ),
                      10.verticalSpace(context),
                      AppTextWidget(
                        text: AppConstantStrings.incomeTracker,
                      ),
                      5.verticalSpace(context),
                      BlocConsumer<IncomeByCategoryBloc, IncomeByCategoryState>(
                        listener: (context, state) {
                          if (state is IncomeByCategoryError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.errorMessage)));
                          }
                        },
                        builder: (context, state) {
                          if (state is IncomeByCategoryLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (state is IncomeByCategoryLoaded) {
                            final categoryIncome =
                                state.categoryIncomeByCategory;
                            if (categoryIncome.isEmpty) {
                              return Text("No income data available.");
                            }
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: categoryIncome.length,
                              itemBuilder: (context, index) {
                                final entry = categoryIncome[index];
                                return IncomeProgressBarWidget(
                                  title: entry['category'],
                                  amount: '₹ ${entry['total']}',
                                );
                              },
                            );
                          }
                          return Center(
                              child: Text("No income data available."));
                        },
                      ),
                      10.verticalSpace(context),
                      BlocConsumer<IncomeByDateBloc, IncomeByDateState>(
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
                            return Center(
                                child: Text("Error: ${state.errorMessage}"));
                          }

                          if (state is IncomeByDateLoaded) {
                            final groupedData = state.groupedData;

                            return ListView.separated(
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
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: AppColor.kArrowColor,
                                                  )),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                child: Column(
                                                  spacing: 10,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        AppTextWidget(
                                                          text:
                                                              '${income.currency} ${income.amount}',
                                                          size: 16,
                                                          weight:
                                                              FontWeight.w600,
                                                          align:
                                                              TextAlign.start,
                                                        ),
                                                        AppTextWidget(
                                                          text: income.category,
                                                          size: 15,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              139, 139, 139),
                                                          weight:
                                                              FontWeight.w500,
                                                          align:
                                                              TextAlign.start,
                                                        ),
                                                        AppTextWidget(
                                                          text: AppDateFormates
                                                              .normalFormatTime(
                                                                  income
                                                                      .createdAt!),
                                                          size: 15,
                                                          color: AppColor
                                                              .kArrowColor,
                                                          weight:
                                                              FontWeight.w500,
                                                          align:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SizedBox(
                                                          // color: Colors.amber,
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width /
                                                                  2,
                                                          child: AppTextWidget(
                                                            text:
                                                                income.comment,
                                                            size: 15,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                139, 139, 139),
                                                            weight:
                                                                FontWeight.w500,
                                                            align:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.dialog(Dialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                shape:
                                                                    ContinuousRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                child:
                                                                    DeleteDialogeBox(
                                                                  deleteWhat:
                                                                      'Income',
                                                                  ontap: () {
                                                                    IncomeDb
                                                                        .deleteIncome(
                                                                      context,
                                                                      //Issue here ------------------------------------------------------------------------------------------------------------------------
                                                                      AppDateFormates
                                                                          .monthFormattedDate(
                                                                              DateTime.now()),
                                                                      income
                                                                          .id!,
                                                                    );
                                                                  },
                                                                )));
                                                            // IncomeDb
                                                            //     .deleteIncome(
                                                            //   context,
                                                            //   AppDateFormates
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

                          return Center(
                              child: Text("No data available for this month."));
                        },
                      ),
                      30.verticalSpace(context),
                    ],
                  ),
                );
              }),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isListExpanded,
          builder: (context, isExpanded, _) {
            return Positioned(
              bottom: 20,
              right: 10,
              child: AnimatedOpacity(
                opacity: !isExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                child: !isExpanded
                    ? FloatingActionButton(
                        onPressed: () {
                          Get.bottomSheet(
                            MoneyKeyboardBottomSheet(
                              isIncomeSheet: true,
                              isExpanseSheet: false,
                              title: AppConstantStrings.income,
                            ),
                            isDismissible: true,
                            enableDrag: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Icon(Icons.add),
                      )
                    : SizedBox(),
              ),
            );
          },
        ),
      ],
    );
  }
}
