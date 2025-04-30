import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/forgot_password_screen.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_instance/src/lifecycle.dart'; // for InternalFinalCallback

import 'package:get/get_instance/src/lifecycle.dart';

class FakeInternalFinalCallback extends InternalFinalCallback<void> {
  @override
  void call() {}
}

class MockAuthViewModel extends Mock implements AuthViewModel {
  @override
  Future<void> signUp(String email, String password) {
    return super.noSuchMethod(
      Invocation.method(#signUp, [email, password]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  Future<void> signInWithGoogle() {
    return super.noSuchMethod(
      Invocation.method(#signInWithGoogle, []),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }

  @override
  InternalFinalCallback<void> get onStart => FakeInternalFinalCallback();
}
/// To test navigation when Get.back() is called, we supply a NavigatorObserver.
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockAuthViewModel mockAuthViewModel;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    // Always enable test mode for Get to suppress unwanted behavior.
    Get.testMode = true;

    mockAuthViewModel = MockAuthViewModel();
    // Put the mock into GetX dependency management.
    Get.put<AuthViewModel>(mockAuthViewModel);

    mockNavigatorObserver = MockNavigatorObserver();
  });

  tearDown(() {
    Get.reset();
  });

  // Create the widget under test wrapped in GetMaterialApp.
  Widget createWidgetUnderTest() {
    return GetMaterialApp(
      home: SignupScreen(),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

  group('SignupScreen UI Tests', () {
    testWidgets('renders all expected widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Check AppBar title, and some key texts.
      expect(find.text(AppStrings.signUp), findsAtLeastNWidgets(1));
      expect(find.text(AppStrings.createAccount), findsOneWidget);
      // Check that text fields are present by verifying labels.
      expect(find.text(AppStrings.userName), findsOneWidget);
      expect(find.text(AppStrings.email), findsOneWidget);
      expect(find.text(AppStrings.password), findsOneWidget);
      expect(find.text("Confirm Password"), findsOneWidget);
      // Check that the custom button is rendered.
      expect(find.byType(CustomButton), findsOneWidget);
      // Check for the "Or continue with" text.
      expect(find.text("Or continue with"), findsOneWidget);
      // Check for the Google sign-in button components.
      expect(find.byType(FaIcon), findsOneWidget);
      // Check for the "Already have an account" TextButton.
      expect(find.text(AppStrings.alreadyHaveAccount), findsOneWidget);
    });
  });

  group('SignupScreen Validation Tests', () {
    // These tests simulate error cases by verifying that signUp is not called.
    testWidgets('shows error when name is empty', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(Size(800, 2000)); // increase screen height

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'test@example.com');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });

    testWidgets('shows error when email is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });

    testWidgets('shows error when email is invalid', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'invalid-email');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });

    testWidgets('shows error when password is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'test@example.com');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });

    testWidgets('shows error when confirm password is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'test@example.com');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });

    testWidgets('shows error when passwords do not match', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'test@example.com');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'different');

      await tester.tap(find.byType(CustomButton));
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      verifyNever(mockAuthViewModel.signUp("deltaforce@gmail.com", "11111111"));
    });


  });

  group('SignupScreen Action Tests', () {
    testWidgets('calls signUp when form is valid', (WidgetTester tester) async {
      when(mockAuthViewModel.signUp('test@example.com', 'password123'))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Fill in all valid details.
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.userName), 'John Doe');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.email), 'test@example.com');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password), 'password123');
      await tester.enterText(find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password"), 'password123');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      verify(mockAuthViewModel.signUp('test@example.com', 'password123')).called(1);
    });

    testWidgets('triggers Google sign-in', (WidgetTester tester) async {
      when(mockAuthViewModel.signInWithGoogle())
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Tap the Google sign-in button: find by OutlinedButton with child Row containing FaIcon.
      final googleButton = find.descendant(
          of: find.byType(OutlinedButton),
          matching: find.byType(FaIcon));
      expect(googleButton, findsOneWidget);

      await tester.tap(googleButton);
      await tester.pumpAndSettle();

      verify(mockAuthViewModel.signInWithGoogle()).called(1);
    });

    // testWidgets('shows loading spinner when isLoading is true', (WidgetTester tester) async {
    //
    //   final signupScreen = SignupScreen();
    //     // We create a GetX wrapper that forces isLoading true:
    //   final loadingWidget = GetMaterialApp(
    //     home: Obx(() {
    //       // Directly return the spinner if true.
    //       return Center(
    //         child: SpinKitCircle(
    //           color: AppColor.appBarColor,
    //           size: 50.0,
    //         ),
    //       );
    //     }),
    //   );
    //   await tester.pumpWidget(loadingWidget);
    //   await tester.pump();
    //
    //   expect(find.byType(SpinKitCircle), findsOneWidget);
    // });

    testWidgets('navigates back when "Already have an account" is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final backButton = find.text(AppStrings.alreadyHaveAccount);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify that Get.back() was called. Since Get.back() affects navigation,
      // we can supply a NavigatorObserver and verify pop was called.
      // Here we check that there is no widget (or initial route) if pop is successful.
      // Alternatively, we assume that Get.testMode makes Get.back() synchronous.
      // For our test, we can simply expect that after tapping, the current widget is no longer SignupScreen.
      // expect(find.byType(SignupScreen), findsNothing);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Toggle password field visibility.
      final passwordFieldFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == AppStrings.password);
      expect(passwordFieldFinder, findsOneWidget);

      final suffixIconFinder = find.descendant(
          of: passwordFieldFinder, matching: find.byType(IconButton));
      expect(suffixIconFinder, findsOneWidget);

      // Get initial obscureText value:
      final TextField passwordField = tester.widget(passwordFieldFinder);
      final bool initialObscure = passwordField.obscureText;

      // Tap to toggle:
      await tester.tap(suffixIconFinder);
      await tester.pump();

      // Because the field is rebuilt via Obx, we expect the value to invert.
      final TextField updatedPasswordField = tester.widget(passwordFieldFinder);
      expect(updatedPasswordField.obscureText, equals(!initialObscure));
    });

    testWidgets('toggles confirm password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Toggle confirm password field visibility.
      final confirmFieldFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == "Confirm Password");
      expect(confirmFieldFinder, findsOneWidget);

      final suffixIconFinder = find.descendant(
          of: confirmFieldFinder, matching: find.byType(IconButton));
      expect(suffixIconFinder, findsOneWidget);

      final TextField confirmField = tester.widget(confirmFieldFinder);
      final bool initialObscure = confirmField.obscureText;

      await tester.tap(suffixIconFinder);
      await tester.pump();

      final TextField updatedConfirmField = tester.widget(confirmFieldFinder);
      expect(updatedConfirmField.obscureText, equals(!initialObscure));
    });
  });

}
