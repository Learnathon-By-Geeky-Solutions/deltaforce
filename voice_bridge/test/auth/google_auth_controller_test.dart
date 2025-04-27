import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/authentication/services/google_auth_controller.dart';

// Auto-generate Mocks
@GenerateMocks([GoogleSignIn, GoogleSignInAccount])
import 'google_auth_controller_test.mocks.dart';

void main() {
  late GoogleSignInController googleSignInController;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    googleSignInController = GoogleSignInController(mockGoogleSignIn);
  });

  group('GoogleSignInController', () {
    test('login should set googleUser after successful login', () async {
      // Arrange
      final mockGoogleUser = MockGoogleSignInAccount();

      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleUser);

      // Act
      await googleSignInController.login();

      // Assert
      expect(googleSignInController.googleUser, mockGoogleUser);
    });

    test('logout should set googleUser to null after logout', () async {
      // Arrange
      when(mockGoogleSignIn.signOut()).thenAnswer((_) async => null);

      // Act
      await googleSignInController.logout();

      // Assert
      expect(googleSignInController.googleUser, null);
    });
  });
}
