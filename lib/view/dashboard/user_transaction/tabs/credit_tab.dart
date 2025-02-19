import 'package:cash_indo/controller/db/credit_db/credit_db.dart';
import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/core/formats/formats_functions.dart';
import 'package:cash_indo/model/contact_model.dart';
import 'package:cash_indo/model/credit_model.dart';
import 'package:cash_indo/view/dashboard/user_transaction/bloc/credit/credit_list_bloc.dart';
import 'package:cash_indo/view/dashboard/user_transaction/widgets/user_transaction_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:cash_indo/widget/chart_widgets.dart';
import 'package:cash_indo/widget/expansion_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

List<Contact>? contacts;

class CreditTab extends StatelessWidget {
  CreditTab({
    super.key,
    required this.contactModel,
  });
  final ContactModel contactModel;
  // final FlutterNativeContactPicker _contactPicker =
  //     FlutterNativeContactPicker();

  final ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    isListExpanded.value = false;
    CreditDb.fetchCredit(context, contactModel.phoneNumber);
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
                          sections: paiChartDatas(false),
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
              SizedBox(
                // color: Colors.amber,
                child: BlocConsumer<CreditListBloc, CreditListState>(
                  listener: (context, state) {
                    if (state is CreditListError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CreditListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is CreditListError) {
                      return Center(child: Text("Error: ${state.message}"));
                    }

                    if (state is CreditListLoaded) {
                      final creditList = state.credits;

                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.credits.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final credit = creditList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TransactionListTile(
                                phoneNumber: contactModel.phoneNumber,
                                id: credit.id!,
                                currency: credit.currency,
                                isDebt: false,
                                amount: credit.amount.toString(),
                                comment: credit.comment,
                                date: AppFormats.slashFormattedDate(
                                    credit.createdAt!),
                                isIncreasing: credit.isAdding!,
                                isWhatsAppMessageSend: credit.isSend!,
                                time: AppFormats.normalFormatTime(
                                    credit.createdAt!),
                              ),
                            );
                          });
                    }

                    return Center(
                        child: Text("No credit transactions available."));
                  },
                ),
              ),
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
                        text: AppConstantStrings.credit,
                        contactModel: contactModel,
                        isDebt: false,
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
