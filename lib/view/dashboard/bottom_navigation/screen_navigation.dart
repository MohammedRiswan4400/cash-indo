import 'package:cash_indo/core/color/app_color.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class ScreenNavigations extends StatelessWidget {
  const ScreenNavigations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (BuildContext context, int newIndex, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BottomNavigationBar(
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              currentIndex: newIndex,
              elevation: 20,
              backgroundColor: AppColor.kContainerColor,
              iconSize: 28,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              showUnselectedLabels: false,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                textBaseline: TextBaseline.alphabetic,
              ),
              unselectedFontSize: 12,
              selectedItemColor: AppColor.kBackgroundColor,
              unselectedItemColor: AppColor.kBackgroundColor,
              items: [
                BottomNavigationBarItem(
                  icon: indexChangeNotifier.value == 0
                      ? const Icon(Icons.account_balance)
                      : const Icon(Icons.account_balance_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: indexChangeNotifier.value == 1
                      ? const Icon(Icons.account_balance_wallet_rounded)
                      : const Icon(Icons.account_balance_wallet_outlined),
                  label: "Expenses",
                ),
                BottomNavigationBarItem(
                  icon: indexChangeNotifier.value == 2
                      ? const Icon(Icons.note_add)
                      : const Icon(Icons.note_add_outlined),
                  label: "My Sheet",
                ),
                BottomNavigationBarItem(
                  icon: indexChangeNotifier.value == 3
                      ? const Icon(Icons.settings)
                      : const Icon(Icons.settings_outlined),
                  label: "Settings",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
