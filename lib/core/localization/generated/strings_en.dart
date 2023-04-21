import 'strings.dart';

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get register => 'Register';

  @override
  String get forgotPassword => 'Forgot passoword?';

  @override
  String get signOut => 'Sign out';

  @override
  String get failed => 'Error!';

  @override
  String get succeed => 'Well done!';

  @override
  String get loremIpsum => 'Lorem ipsum dolor sit amet, consectetur';
}
