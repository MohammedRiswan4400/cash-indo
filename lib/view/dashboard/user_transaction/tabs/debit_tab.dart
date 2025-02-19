import 'package:cash_indo/controller/db/debit_db/debit_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/bloc/debit/debit_list_bloc.dart';
import 'package:cash_indo/view/dashboard/user_transaction/widgets/user_transaction_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:cash_indo/widget/chart_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebitTab extends StatelessWidget {
  const DebitTab({
    super.key,
    required this.contactModel,
  });
  final ContactModel contactModel;
  @override
  Widget build(BuildContext context) {
    isListExpanded.value = false;
    DebitDb.fetchDebit(context, contactModel.phoneNumber);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                text: 'Balance',
                weight: FontWeight.w600,
                color: AppColor.kArrowColor,
              ),
              AppTextWidget(
                text: '\$ 34,590.00',
                size: 30,
                weight: FontWeight.bold,
                color: AppColor.kArrowColor,
              ),
              20.verticalSpace(context),
              Center(
                child: SizedBox(
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColor.kArrowColor, width: 10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: PieChart(
                        PieChartData(
                          sections: paiChartDatas(true),
                          centerSpaceRadius: 0,
                          sectionsSpace: 0,
                          startDegreeOffset: 0,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              5.verticalSpace(context),
              AppTextWidget(
                text: '75% Completds',
                size: 15,
                weight: FontWeight.bold,
                color: AppColor.kArrowColor,
              ),
              20.verticalSpace(context),
              10.verticalSpace(context),
              // TransactionListTile(
              //   phoneNumber: '',
              //   id: 1,
              //   currency: '',
              //   isDebt: true,
              //   amount: '2000',
              //   comment: '',
              //   date: DateTime.now().toString(),
              //   isIncreasing: false,
              //   isWhatsAppMessageSend: true,
              //   time: DateTime.now().toString(),
              // ),
              SizedBox(
                // color: Colors.amber,
                child: BlocConsumer<DebitListBloc, DebitListState>(
                  listener: (context, state) {
                    if (state is DebitListError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DebitListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is DebitListError) {
                      return Center(child: Text("Error: ${state.message}"));
                    }

                    if (state is DebitListLoaded) {
                      final debitList = state.debits;

                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.debits.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final debit = debitList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TransactionListTile(
                                phoneNumber: contactModel.phoneNumber,
                                id: debit.id!,
                                currency: debit.currency,
                                isDebt: true,
                                amount: debit.amount.toString(),
                                comment: debit.comment,
                                date: AppFormats.slashFormattedDate(
                                    debit.createdAt!),
                                isIncreasing: debit.isAdding!,
                                isWhatsAppMessageSend: debit.isSend!,
                                time: AppFormats.normalFormatTime(
                                    debit.createdAt!),
                              ),
                            );
                          });
                    }

                    return Center(
                        child: Text("No debit transactions available."));
                  },
                ),
              ),

              // Divider(),
              // TransactionListTile(
              //   currency: '',
              //   isDebt: true,
              //   amount: '',
              //   comment: '',
              //   date: '',
              //   isIncreasing: false,
              //   isWhatsAppMessageSend: false,
              //   time: '',
              // ),
              // Divider(),
              // TransactionListTile(
              //   currency: '',
              //   isDebt: true,
              //   amount: '',
              //   comment: '',
              //   date: '',
              //   isIncreasing: true,
              //   isWhatsAppMessageSend: false,
              //   time: '',
              // ),
            ],
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isListExpanded,
          builder: (context, isExpanded, _) {
            return Positioned(
              bottom: 10,
              right: 2,
              left: 2,
              child: AnimatedOpacity(
                opacity: !isExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                child: !isExpanded
                    ? LiabilitiesAddingWidget(
                        text: AppConstantStrings.debt,
                        contactModel: contactModel,
                        isDebt: true,
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
