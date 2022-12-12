import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/model/catagory_data_model.dart';
import 'package:money_app/model/user_name_data_model.dart';
import 'package:money_app/screen/splash_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'model/transaction_data_model.dart';

const saveKeyValue = 'UserRegistered';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializeTimeZone();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CatagoryModelAdapter().typeId)) {
    Hive.registerAdapter(CatagoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(UserNameModelAdapter().typeId)) {
    Hive.registerAdapter(UserNameModelAdapter());
  }
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const ScreenSplash(),
    );
  }
}
