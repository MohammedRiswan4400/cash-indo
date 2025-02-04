import 'package:cash_indo/core/color/app_color.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/constant/spacing_extensions.dart';
import 'package:cash_indo/view/dashboard/user_transaction/widgets/user_transaction_widgets.dart';
import 'package:cash_indo/widget/app_text_widget.dart';
import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:cash_indo/widget/chart_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

List<Contact>? contacts;

class CreditTab extends StatelessWidget {
  CreditTab({
    super.key,
  });

  // final FlutterNativeContactPicker _contactPicker =
  //     FlutterNativeContactPicker();

  final ValueNotifier<List<Contact>> contactsNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
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
              10.verticalSpace(context),
              TransactionListTile(
                isDebt: false,
                amount: '',
                comment: '',
                date: '',
                isDecreasing: false,
                isWhatsAppMessageSend: false,
                time: '',
              ),
              Divider(),
              TransactionListTile(
                isDebt: false,
                amount: '',
                comment: '',
                date: '',
                isDecreasing: false,
                isWhatsAppMessageSend: false,
                time: '',
              ),
              Divider(),
              TransactionListTile(
                isDebt: false,
                amount: '',
                comment: '',
                date: '',
                isDecreasing: false,
                isWhatsAppMessageSend: false,
                time: '',
              ),
            ],
          ),
        ),
        LiabilitiesAddingWidget(
          text: AppConstantStrings.credit,
          isDebt: false,
        )
      ],
    );
  }
}
