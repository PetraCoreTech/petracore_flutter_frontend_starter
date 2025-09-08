import 'package:test/test.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/validation.dart';

void main() {
  group('Validation', () {
    group('isValidDartPackageName', () {
      test('should return true for valid package names', () {
        expect(Validation.isValidDartPackageName('my_app'), isTrue);
        expect(Validation.isValidDartPackageName('flutter_app'), isTrue);
        expect(Validation.isValidDartPackageName('my_awesome_app'), isTrue);
        expect(Validation.isValidDartPackageName('app123'), isTrue);
      });

      test('should return false for invalid package names', () {
        expect(Validation.isValidDartPackageName(''), isFalse);
        expect(Validation.isValidDartPackageName('a'), isFalse);
        expect(Validation.isValidDartPackageName('MyApp'), isFalse);
        expect(Validation.isValidDartPackageName('my-app'), isFalse);
        expect(Validation.isValidDartPackageName('my app'), isFalse);
        expect(Validation.isValidDartPackageName('_myapp'), isFalse);
        expect(Validation.isValidDartPackageName('myapp_'), isFalse);
        expect(Validation.isValidDartPackageName('my__app'), isFalse);
        expect(Validation.isValidDartPackageName('class'), isFalse);
        expect(Validation.isValidDartPackageName('void'), isFalse);
      });
    });

    group('isValidFeatureName', () {
      test('should return true for valid feature names', () {
        expect(Validation.isValidFeatureName('auth'), isTrue);
        expect(Validation.isValidFeatureName('user_profile'), isTrue);
        expect(Validation.isValidFeatureName('chat_feature'), isTrue);
        expect(Validation.isValidFeatureName('api_service'), isTrue);
      });

      test('should return false for invalid feature names', () {
        expect(Validation.isValidFeatureName(''), isFalse);
        expect(Validation.isValidFeatureName('a'), isFalse);
        expect(Validation.isValidFeatureName('Auth'), isFalse);
        expect(Validation.isValidFeatureName('user-profile'), isFalse);
        expect(Validation.isValidFeatureName('user profile'), isFalse);
        expect(Validation.isValidFeatureName('_auth'), isFalse);
        expect(Validation.isValidFeatureName('auth_'), isFalse);
        expect(Validation.isValidFeatureName('user__profile'), isFalse);
      });
    });

    group('isValidClassName', () {
      test('should return true for valid class names', () {
        expect(Validation.isValidClassName('MyClass'), isTrue);
        expect(Validation.isValidClassName('UserProfile'), isTrue);
        expect(Validation.isValidClassName('ApiService'), isTrue);
        expect(Validation.isValidClassName('A'), isTrue);
      });

      test('should return false for invalid class names', () {
        expect(Validation.isValidClassName(''), isFalse);
        expect(Validation.isValidClassName('myClass'), isFalse);
        expect(Validation.isValidClassName('my_class'), isFalse);
        expect(Validation.isValidClassName('MyClass123_'), isFalse);
        expect(Validation.isValidClassName('My-Class'), isFalse);
        expect(Validation.isValidClassName('My Class'), isFalse);
      });
    });
  });
}
