import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voice_bridge/features/Settings/service/theme_service.dart';
import 'package:voice_bridge/features/Settings/view-model/settings_view_model.dart';
import 'package:voice_bridge/resources/getx_localization/languages.dart';
import 'package:voice_bridge/resources/routes/routes.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(AuthViewModel());
  Get.put(ThemeViewModel());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeService _themeService = ThemeService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        translations: Languages(),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeService.theme,

        getPages: AppRoutes.appRoutes(),
        // base: SplashScreen(),
      ),
    );
  }
}
