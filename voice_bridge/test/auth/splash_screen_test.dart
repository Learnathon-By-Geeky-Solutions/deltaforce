import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/splash_screen.dart';

// Mock AuthViewModel
class MockAuthViewModel extends GetxService with Mock implements AuthViewModel {}

void main() {
  late MockAuthViewModel mockAuthViewModel;

  setUp(() {
    mockAuthViewModel = MockAuthViewModel();
    Get.put<AuthViewModel>(mockAuthViewModel); // Inject into GetX
  });

  testWidgets('SplashScreen shows app name and calls checkUserLoggedIn after delay', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        home: SplashScreen(),
      ),
    );

    // Assert UI immediately
    expect(find.text(AppStrings.appName), findsOneWidget);

    // Fast-forward 2 seconds
    await tester.pump(const Duration(seconds: 2));

    // Verify that checkUserLoggedIn is called
    verify(mockAuthViewModel.checkUserLoggedIn()).called(1);
  });
}
