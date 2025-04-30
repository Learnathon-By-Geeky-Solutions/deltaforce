import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/change_password.dart';
import 'package:voice_bridge/features/authentication/views/auth/forgot_password_screen.dart';

class FakeInternalFinalCallback extends InternalFinalCallback<void> {
  @override
  void call() {}
}

class MockAuthViewModel extends Mock implements AuthViewModel {
  @override
  InternalFinalCallback<void> get onStart => FakeInternalFinalCallback();

  @override
  Future<void> updatePassword(String oldPassword, String newPassword) {
    return super.noSuchMethod(
      Invocation.method(#updatePassword, [oldPassword, newPassword]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    );
  }
}

void main() {
  late MockAuthViewModel mockAuthViewModel;

  setUp(() {
    mockAuthViewModel = MockAuthViewModel();
    Get.put<AuthViewModel>(mockAuthViewModel);
  });

  tearDown(() {
    Get.reset();
  });

  Widget createWidgetUnderTest() {
    return const GetMaterialApp(
      home: PasswordUpdateScreen(),
    );
  }

  group('PasswordUpdateScreen UI Tests', () {
    testWidgets('renders all expected widgets', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Current Password'), findsOneWidget);
      expect(find.text('New Password'), findsOneWidget);
      expect(find.text('Re-enter New Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Update Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
    });
  });

  group('PasswordUpdateScreen Interaction Tests', () {
    testWidgets('shows error when passwords do not match', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byKey(const Key('new_password_field')), 'newPass123');
      await tester.enterText(find.byKey(const Key('re_enter_password_field')), 'differentPass');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Update Password'));
      await tester.pump(); // show snackbar

      expect(find.text('Passwords do not match'), findsOneWidget);

      // Wait long enough for snackbar + manual close
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsNothing);
    });

    testWidgets('calls updatePassword when form is valid', (WidgetTester tester) async {
      when(mockAuthViewModel.updatePassword('oldPass', 'newPass123'))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byKey(const Key('current_password_field')), 'oldPass');
      await tester.enterText(find.byKey(const Key('new_password_field')), 'newPass123');
      await tester.enterText(find.byKey(const Key('re_enter_password_field')), 'newPass123');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Update Password'));
      await tester.pump();

      verify(mockAuthViewModel.updatePassword('oldPass', 'newPass123')).called(1);
    });

    testWidgets('navigates to ForgotPasswordScreen when link is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordScreen), findsOneWidget);
    });

    testWidgets('toggles new password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final iconButton = find.descendant(
        of: find.byKey(const Key('new_password_field')),
        matching: find.byType(IconButton),
      );

      expect(iconButton, findsOneWidget);
      await tester.tap(iconButton);
      await tester.pump();

      // Check that the visibility icon toggles (optional advanced: check obscureText flip)
    });
  });
}
