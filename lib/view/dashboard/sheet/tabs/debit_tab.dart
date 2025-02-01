import 'package:cash_indo/core/routes/app_routes.dart';
import 'package:cash_indo/view/dashboard/sheet/widgets/sheet_widgets.dart';

import 'package:cash_indo/widget/balance_sheet_widgets.dart';
import 'package:flutter/material.dart';

class DebitTab extends StatelessWidget {
  const DebitTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AddContactWidget(),
        ),
        ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  AppRoutes.gotoScreenUserTransaction(true);
                },
                child: UserListTile());
          },
        )
      ],
    );
  }
}
