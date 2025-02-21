
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/resources/getx_localization/languages.dart';
import 'package:voice_bridge/resources/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Languages(),
      locale: Locale('en' , 'US'),
      fallbackLocale: Locale('en' , 'US'),// if locale language is not supported for the device

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.appBarColor),
        useMaterial3: true,
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
