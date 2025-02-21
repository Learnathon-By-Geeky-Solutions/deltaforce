import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/resources/getx_localization/languages.dart';
import 'package:voice_bridge/resources/routes/routes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized before running the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: AppStrings.appName,
      // theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Flutter Demo',
      translations: Languages(),
      locale: Locale('en' , 'US'),
      fallbackLocale: Locale('en' , 'US'),// if locale language is not supported for the device
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.appBarColor),
        useMaterial3: true,
      ),

      getPages: AppRoutes.appRoutes(),
      // base: SplashScreen(),
    );
  }
}
