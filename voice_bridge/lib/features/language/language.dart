import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';

class AppLanguageTexts extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{

  'en': {
  'login': AppStrings.login,
  'welcome_back': 'Welcome Back',
  'email': AppStrings.email,
  'password': AppStrings.password,
  'dont_have_an_account': AppStrings.dontHaveAccount,
  'or_continue_with': 'Or continue with',
  'sign_in_with': 'Sign in with Google',
  },
  'bn': {
  'login': 'লগইন',
  'welcome_back': 'পুনরায় স্বাগতম',
  'email': 'ইমেইল লিখুন',
  'password': 'পাসওয়ার্ড লিখুন',
  'dont_have_an_account': 'একাউন্ট নেই? সাইন আপ করুন',
  'or_continue_with': 'অথবা চালিয়ে যান',
  'sign_in_with': 'গুগল সাইন ইন করুন',
  }
  };
}
