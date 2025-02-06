import 'package:cash_indo/controller/theme/theme_controller.dart';
import 'package:cash_indo/core/constant/app_const.dart';
import 'package:cash_indo/core/constant/app_texts.dart';
import 'package:cash_indo/core/theme/theme_helper.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/expanses/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/category/by_category_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/date/by_date_bloc.dart';
import 'package:cash_indo/view/dashboard/expense_tracker/tabs/bloc/income/monthly_total/income_monthly_total_bloc.dart';
import 'package:cash_indo/view/dashboard/sheet/bloc/contact_bloc.dart';
import 'package:cash_indo/view/splash/screen_splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Supabase.initialize(
    url: AppConst.supaURL,
    anonKey: AppConst.supaKey,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IncomeMonthlyTotalBloc(),
        ),
        BlocProvider<IncomeByDateBloc>(
          create: (context) => IncomeByDateBloc(),
        ),
        BlocProvider<ExpenseByDateBloc>(
          create: (context) => ExpenseByDateBloc(),
        ),
        BlocProvider<IncomeByCategoryBloc>(
          create: (context) => IncomeByCategoryBloc(),
        ),
        BlocProvider(
          create: (context) => ContactBloc()..add(FetchContactsEvent()),
        ),
      ],
      child: Obx(() {
        return GetMaterialApp(
          title: AppConstantStrings.appName,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: ScreenSplash(),
        );
      }),
    );
  }
}
