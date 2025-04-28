import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart'; // <-- ADD THIS
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';

import 'mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;


  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser; // <-- ADD THIS
  late FirebaseAuthService authService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser(); // <-- ADD THIS

    authService = FirebaseAuthService(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
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
}


