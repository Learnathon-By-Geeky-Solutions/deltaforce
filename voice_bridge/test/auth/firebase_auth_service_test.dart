import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';

import 'mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;


  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFacebookAuth mockFacebookAuth;

  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser; // <-- ADD THIS
  late FirebaseAuthService authService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFacebookAuth = MockFacebookAuth();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser(); // <-- ADD THIS

    authService = FirebaseAuthService(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
      facebookAuth:  mockFacebookAuth,
    );
  });

  group('FirebaseAuthService', () {
    testWidgets('signInWithGoogle success', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(),
        ),
      );

      // Arrange
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
      when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(mockGoogleSignInAuthentication.accessToken).thenReturn('fake_access_token');
      when(mockGoogleSignInAuthentication.idToken).thenReturn('fake_id_token');
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      // Act
      final user = await authService.signInWithGoogle();

      // Assert
      expect(user, isNotNull);
    });

    testWidgets('signInWithGoogle cancelled', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(),
        ),
      );

      // Arrange
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      // Act
      final user = await authService.signInWithGoogle();

      // Wait for snackbar animations, etc.
      await tester.pumpAndSettle();

      // Assert
      expect(user, isNull);
    });
  });

  group('FirebaseAuthService', () {
    setUp(() {
      Get.reset();
    });

    testWidgets('signUpWithEmailAndPassword success', (tester) async {
      // Arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await authService.signUpWithEmailAndPassword('test@example.com', 'password123');

      // Assert
      expect(result, isNotNull);
    });

    testWidgets('signInWithEmailAndPassword success', (tester) async {
      // Arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await authService.signInWithEmailAndPassword('test@example.com', 'password123');

      // Assert
      expect(result, isNotNull);
    });

    testWidgets('sendPasswordResetEmail success', (tester) async {
      // Arrange
      when(mockFirebaseAuth.sendPasswordResetEmail(email: anyNamed('email')))
          .thenAnswer((_) async => {});

      // Act
      await authService.sendPasswordResetEmail('test@example.com');

      // Assert
      verify(mockFirebaseAuth.sendPasswordResetEmail(email: 'test@example.com')).called(1);
    });

    testWidgets('updatePassword success', (tester) async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.email).thenReturn('test@example.com');
      when(mockUser.reauthenticateWithCredential(any)).thenAnswer((_) async => mockUserCredential);
      when(mockUser.updatePassword(any)).thenAnswer((_) async => {});

      // Act
      await authService.updatePassword('oldPassword123', 'newPassword456');

      // Assert
      verify(mockUser.reauthenticateWithCredential(any)).called(1);
      verify(mockUser.updatePassword('newPassword456')).called(1);
    });

    testWidgets('reloadUser success', (tester) async {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.reload()).thenAnswer((_) async => {});

      // Act
      await authService.reloadUser();

      // Assert
      verify(mockUser.reload()).called(1);
    });
    testWidgets('signOut success', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(),
        ),
      );

      // Arrange
      when(mockGoogleSignIn.signOut()).thenAnswer((_) async => Future.value(null));
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});
      when(mockFacebookAuth.logOut()).thenAnswer((_) async {});  // <-- ADD THIS

      // Act
      await authService.signOut();
      // Assert
      verify(mockGoogleSignIn.signOut()).called(1);   // Check Google signout
      verify(mockFirebaseAuth.signOut()).called(1);   // Check Firebase signout
      verify(mockFacebookAuth.logOut()).called(1);    // Check Facebook logout
    });

  });

  test('FirebaseAuthService constructor works', () {
    final service = FirebaseAuthService(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
      facebookAuth: mockFacebookAuth,
    );

    expect(service, isNotNull);
  });


  testWidgets('signInWithGoogle - user cancels', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(),
      ),
    );

    // Arrange
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

    // Act
    final user = await authService.signInWithGoogle();

    // Let snackbar animations finish
    await tester.pumpAndSettle();

    // Assert
    expect(user, isNull);
    verify(mockGoogleSignIn.signIn()).called(1);
  });




  testWidgets('signInWithGoogle - throws exception', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(),
      ),
    );

    // Arrange
    when(mockGoogleSignIn.signIn()).thenThrow(Exception('Google Sign-In failed'));

    // Act
    final user = await authService.signInWithGoogle();

    // Let snackbar animations finish
    await tester.pumpAndSettle();

    // Assert
    expect(user, isNull);
    verify(mockGoogleSignIn.signIn()).called(1);
  });


}


