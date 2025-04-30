import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/login_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/forgot_password_screen.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';

class FakeInternalFinalCallback extends InternalFinalCallback<void> {
  @override
  void call() {}
}

class MockAuthViewModel extends Mock implements AuthViewModel {
  @override
  InternalFinalCallback<void> get onStart => FakeInternalFinalCallback();
}
void main() {
  late MockAuthViewModel mockAuth;

  setUp(() {
    Get.testMode = true;
    mockAuth = MockAuthViewModel();
    Get.put<AuthViewModel>(mockAuth);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidgetUnderTest() {
    return GetMaterialApp(home: LoginScreen());
  }

  testWidgets('renders login UI components', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text(AppStrings.login), findsWidgets);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text(AppStrings.email), findsOneWidget);
    expect(find.text(AppStrings.password), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text(AppStrings.dontHaveAccount), findsOneWidget);
    expect(find.byType(FaIcon), findsOneWidget);
  });

  // testWidgets('shows error if email is empty', (WidgetTester tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   await tester.enterText(find.byType(TextField).last, 'password123');
  //   await tester.tap(find.text(AppStrings.login));
  //
  //   await tester.pumpAndSettle();
  //
  //   verifyNever(mockAuth.signIn('test@example.com', '123'));
  // });
  //
  // testWidgets('shows error if email is invalid', (WidgetTester tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   await tester.enterText(find.byType(TextField).first, 'invalidemail');
  //   await tester.enterText(find.byType(TextField).last, 'password123');
  //   await tester.tap(find.text(AppStrings.login));
  //   await tester.pumpAndSettle();
  //
  //   verifyNever(mockAuth.signIn('test@example.com', '123'));
  // });
  //
  // testWidgets('shows error if password is too short', (WidgetTester tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   await tester.enterText(find.byType(TextField).first, 'test@example.com');
  //   await tester.enterText(find.byType(TextField).last, '123');
  //   await tester.tap(find.text(AppStrings.login));
  //   await tester.pumpAndSettle();
  //
  //   verifyNever(mockAuth.signIn('test@example.com', '123'));
  // });

  // testWidgets('calls signIn with valid input', (WidgetTester tester) async {
  //   when(mockAuth.signIn('test@example.com', '123')).thenAnswer((_) async {});
  //
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   await tester.enterText(find.byType(TextField).first, 'test@example.com');
  //   await tester.enterText(find.byType(TextField).last, 'password123');
  //   await tester.tap(find.text(AppStrings.login));
  //   await tester.pumpAndSettle();
  //
  //   verify(mockAuth.signIn('test@example.com', 'password123')).called(1);
  // });
  //
  // testWidgets('calls signInWithGoogle on Google button tap', (WidgetTester tester) async {
  //   when(mockAuth.signInWithGoogle()).thenAnswer((_) async {});
  //
  //   await tester.pumpWidget(createWidgetUnderTest());
  //   await tester.tap(find.byType(OutlinedButton));
  //   await tester.pumpAndSettle();
  //
  //   verify(mockAuth.signInWithGoogle()).called(1);
  // });

  testWidgets('navigates to ForgotPasswordScreen', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    expect(find.byType(ForgotPasswordScreen), findsOneWidget);
  });

  testWidgets('navigates to SignupScreen', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text(AppStrings.dontHaveAccount));
    await tester.pumpAndSettle();

    expect(find.byType(SignupScreen), findsOneWidget);
  });

  testWidgets('toggles password visibility', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final iconButton = find.byIcon(Icons.visibility);
    expect(iconButton, findsOneWidget);

    await tester.tap(iconButton);
    await tester.pump();

    // You can optionally check that it switched to Icons.visibility_off
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
}
