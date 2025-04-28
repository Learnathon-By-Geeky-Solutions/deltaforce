import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/splash_screen.dart';

// Fake AuthViewModel
class FakeAuthViewModel extends GetxService implements AuthViewModel {
  bool wasCalled = false;

  @override
  void checkUserLoggedIn() {
    wasCalled = true;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}


void main() {
  late FakeAuthViewModel fakeAuthViewModel;

  setUp(() {
    Get.reset();
    fakeAuthViewModel = FakeAuthViewModel();
    Get.put<AuthViewModel>(fakeAuthViewModel);
  });

  testWidgets('SplashScreen shows app name and calls checkUserLoggedIn after delay', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.text(AppStrings.appName), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));

    expect(fakeAuthViewModel.wasCalled, isTrue);
  });
}
