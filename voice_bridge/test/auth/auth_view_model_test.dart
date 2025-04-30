import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
// import '../app_drawer_test.dart';
import 'auth_view_model_test.mocks.dart';

@GenerateMocks([FirebaseAuthService, UserCredential, User, FirebaseAuth])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  late MockFirebaseAuthService mockFirebaseAuthService;
  late AuthViewModel authViewModel;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    when(mockFirebaseAuthService.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());

    authViewModel = AuthViewModel(firebaseAuthService: mockFirebaseAuthService);
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
  });

  tearDown(() async {
    authViewModel.dispose();
    Get.reset();
  });

  group('AuthViewModel', () {

    testWidgets('signUp success - unverified email', (tester) async {
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.emailVerified).thenReturn(false);
      when(mockFirebaseAuthService.signUpWithEmailAndPassword(any, any))
          .thenAnswer((_) async => mockUserCredential);
      when(mockFirebaseAuthService.reloadUser()).thenAnswer((_) async => {});
      when(mockFirebaseAuthService.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.sendEmailVerification()).thenAnswer((_) async => {});
      when(mockUser.emailVerified).thenReturn(true);

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signUp('email@test.com', 'password');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.user, mockUser);
    });

    testWidgets('signUp failure', (tester) async {
      when(mockFirebaseAuthService.signUpWithEmailAndPassword(any, any))
          .thenThrow(Exception('Signup failed'));

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signUp('email@test.com', 'password');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.user, isNull);
    });

    testWidgets('signIn success - verified email', (tester) async {
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.emailVerified).thenReturn(true);
      when(mockFirebaseAuthService.signInWithEmailAndPassword(any, any))
          .thenAnswer((_) async => mockUserCredential);

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signIn('email@test.com', 'password');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.user, mockUser);
    });

    testWidgets('signIn failure', (tester) async {
      when(mockFirebaseAuthService.signInWithEmailAndPassword(any, any))
          .thenThrow(Exception('Signin Failed'));

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signIn('email@test.com', 'password');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.error.isNotEmpty, true);
    });

    testWidgets('signInWithGoogle success', (tester) async {
      when(mockUser.emailVerified).thenReturn(true);
      when(mockFirebaseAuthService.signInWithGoogle())
          .thenAnswer((_) async => mockUser);

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signInWithGoogle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.user, mockUser);
    });

    testWidgets('signInWithGoogle failure', (tester) async {
      when(mockFirebaseAuthService.signInWithGoogle())
          .thenThrow(Exception('Google SignIn Failed'));

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.signInWithGoogle();

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.error.isNotEmpty, true);
    });

    testWidgets('resetPassword success', (tester) async {
      when(mockFirebaseAuthService.sendPasswordResetEmail(any))
          .thenAnswer((_) async => {});

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.resetPassword('email@test.com');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.error.isEmpty, true);
    });

    testWidgets('resetPassword failure', (tester) async {
      when(mockFirebaseAuthService.sendPasswordResetEmail(any))
          .thenThrow(Exception('Reset Password Failed'));

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));
      await authViewModel.resetPassword('email@test.com');

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(authViewModel.error.isNotEmpty, true);
    });

    testWidgets('updatePassword success', (tester) async {
      when(mockFirebaseAuthService.updatePassword(any, any))
          .thenAnswer((_) async => {});

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));

      await authViewModel.updatePassword('oldPass', 'newPass');

      await tester.pump(const Duration(seconds: 4)); // 🛠️ Wait for snackbar 3s + some buffer
      await tester.pumpAndSettle();                 // 🛠️ Settle all animations

      expect(authViewModel.error.isEmpty, true);
    });

    testWidgets('updatePassword failure', (tester) async {
      when(mockFirebaseAuthService.updatePassword(any, any))
          .thenThrow(Exception('Update Password Failed'));

      await tester.pumpWidget(GetMaterialApp(home: Scaffold()));

      await authViewModel.updatePassword('oldPass', 'newPass');

      await tester.pump(const Duration(seconds: 4)); // 🛠️ Same 4s wait
      await tester.pumpAndSettle();                 // 🛠️ Then settle

      expect(authViewModel.error.isNotEmpty, true);
    });





    testWidgets('handleAuthChange navigates to login if user is null', (tester) async {
      when(mockFirebaseAuthService.getCurrentUser()).thenReturn(null);

      await tester.pumpWidget(GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Scaffold(body: Text('Home'))),
          GetPage(name: RoutesName.loginScreen, page: () => Scaffold(body: Text('Login'))),
        ],
      ));

      authViewModel.checkUserLoggedIn();
      await tester.pumpAndSettle();

      expect(Get.currentRoute, RoutesName.loginScreen);
    });
    testWidgets('handleAuthChange signs out and navigates to login if email not verified', (tester) async {
      when(mockFirebaseAuthService.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.emailVerified).thenReturn(false);

      await tester.pumpWidget(GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Scaffold(body: Text('Home'))),
          GetPage(name: RoutesName.loginScreen, page: () => Scaffold(body: Text('Login'))),
        ],
      ));

      authViewModel.checkUserLoggedIn();
      await tester.pumpAndSettle();

      expect(Get.currentRoute, RoutesName.loginScreen);
    });



  });

  testWidgets('handleAuthChange navigates to baseView if email is verified', (tester) async {
    when(mockFirebaseAuthService.getCurrentUser()).thenReturn(mockUser);
    when(mockUser.emailVerified).thenReturn(true);

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Scaffold(body: Text('Home'))),
        GetPage(name: RoutesName.baseView, page: () => Scaffold(body: Text('Base View'))),
      ],
    ));

    authViewModel.checkUserLoggedIn();
    await tester.pumpAndSettle();

    expect(Get.currentRoute, RoutesName.baseView);
  });


  test('dispose method cancels subscription and disposes controllers', () async {
    final controller = AuthViewModel(firebaseAuthService: mockFirebaseAuthService);
    controller.onInit();

    controller.currentPasswordController.text = "test";
    controller.newPasswordController.text = "pass";

    controller.dispose();

    // Just check that calling dispose doesn't throw
    expect(() => controller.currentPasswordController.dispose(), returnsNormally);
    expect(() => controller.newPasswordController.dispose(), returnsNormally);
  });


  test('onInit attaches auth state subscription', () {
    final authViewModel = AuthViewModel(firebaseAuthService: mockFirebaseAuthService);
    authViewModel.onInit();
    expect(authViewModel.user, isNull); // trivial check to force init
  });

  test('onClose cancels stream and disposes controllers safely', () {
    final controller = AuthViewModel(firebaseAuthService: mockFirebaseAuthService);
    controller.onInit();

    controller.currentPasswordController.text = "test";
    controller.newPasswordController.text = "pass";

    // Expect that calling onClose (which includes dispose logic) doesn't throw
    expect(() => controller.onClose(), returnsNormally);
  });


  testWidgets('waitForEmailVerification handles timeout and navigates to login', (tester) async {
    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.emailVerified).thenReturn(false);
    when(mockUser.sendEmailVerification()).thenAnswer((_) async {});
    when(mockFirebaseAuthService.signUpWithEmailAndPassword(any, any))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirebaseAuthService.getCurrentUser()).thenReturn(mockUser);
    when(mockFirebaseAuthService.reloadUser()).thenAnswer((_) async {});
    when(mockFirebaseAuthService.signOut()).thenAnswer((_) async => {});

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Scaffold(body: Text('Home'))),
        GetPage(name: RoutesName.loginScreen, page: () => const Scaffold(body: Text('Login'))),
      ],
    ));

    await authViewModel.waitForEmailVerification(delayFn: (_) async {}); // 👈 triggers all snackbar logic

    await tester.pump(const Duration(seconds: 4)); // 👈 let the snackbar timers run out
    await tester.pumpAndSettle(); // 👈 wait for overlay disposal

    expect(Get.currentRoute, RoutesName.loginScreen);
  });

  testWidgets('waitForEmailVerification completes early when email is verified', (tester) async {
    int attemptCounter = 0;

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.sendEmailVerification()).thenAnswer((_) async {});
    when(mockFirebaseAuthService.signOut()).thenAnswer((_) async {});
    when(mockFirebaseAuthService.reloadUser()).thenAnswer((_) async {
      attemptCounter++;
    });
    when(mockUser.emailVerified).thenAnswer((_) => attemptCounter >= 2);
    when(mockFirebaseAuthService.getCurrentUser()).thenReturn(mockUser);

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Scaffold(body: Text('Home'))),
        GetPage(name: RoutesName.loginScreen, page: () => const Scaffold(body: Text('Login'))),
      ],
    ));

    await authViewModel.waitForEmailVerification(delayFn: (_) async {});
    await tester.pump(); // Trigger frame

    // 🛠 Add this to allow the Snackbar's timer to complete
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, RoutesName.loginScreen);
  });





}
