import 'package:get/get.dart';

class AppTabController extends GetxController {
  var selectedTabIndex = 0.obs;

  void updateTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
