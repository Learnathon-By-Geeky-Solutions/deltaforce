import 'package:flutter_test/flutter_test.dart';
import 'package:voice_bridge/features/authentication/validator/input_validator.dart';

void main() {
  group('InputValidator', () {
    group('validateName', () {
      test('returns error when name is empty', () {
        expect(InputValidator.validateName('   '), 'Name cannot be empty.');
      });

      test('returns null when name is valid', () {
        expect(InputValidator.validateName('John'), null);
      });
    });

    group('validateEmail', () {
      test('returns error when email is empty', () {
        expect(InputValidator.validateEmail('   '), 'Email cannot be empty.');
      });

      test('returns error when email is invalid', () {
        expect(InputValidator.validateEmail('invalidemail'), 'Please enter a valid email address.');
        expect(InputValidator.validateEmail('invalid@com'), 'Please enter a valid email address.');
        expect(InputValidator.validateEmail('invalid@.com'), 'Please enter a valid email address.');
      });

      test('returns null when email is valid', () {
        expect(InputValidator.validateEmail('test@example.com'), null);
      });
    });

    group('validatePassword', () {
      test('returns error when password is empty', () {
        expect(InputValidator.validatePassword(''), 'Password cannot be empty.');
      });

      test('returns error when password is too short', () {
        expect(InputValidator.validatePassword('123'), 'Password must be at least 6 characters.');
      });

      test('returns null when password is valid', () {
        expect(InputValidator.validatePassword('123456'), null);
      });
    });

    group('validateConfirmPassword', () {
      test('returns error when confirm password is empty', () {
        expect(InputValidator.validateConfirmPassword('password123', ''), 'Please confirm your password.');
      });

      test('returns error when passwords do not match', () {
        expect(InputValidator.validateConfirmPassword('password123', 'password321'), 'Passwords do not match.');
      });

      test('returns null when passwords match', () {
        expect(InputValidator.validateConfirmPassword('password123', 'password123'), null);
      });
    });
  });
}
