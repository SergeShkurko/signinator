import 'strings.dart';

/// The translations for Russian (`ru`).
class StringsRu extends Strings {
  StringsRu([String locale = 'ru']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get about => 'About';

  @override
  String get selectDate => 'Choose Date';

  @override
  String get selectTime => 'Choose Time';

  @override
  String get select => 'Select';

  @override
  String get cancel => 'Cancel';

  @override
  String get pleaseWait => 'Please Wait...';

  @override
  String get login => 'Войти';

  @override
  String get email => 'Email';

  @override
  String get username => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get register => 'Регистрация';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get failed => 'Ошибка!';

  @override
  String get succeed => 'Успех!';

  @override
  String get loremIpsum => 'Чтобы добиться успеха в жизни нужно только... :)';

  @override
  String get askRegister => 'Don\'t have an Account?';

  @override
  String get errorInvalidEmail => 'Email is not valid';

  @override
  String get errorEmptyField => 'Can\'t be empty';

  @override
  String get passwordRepeat => 'Repeat Password';

  @override
  String get errorPasswordNotMatch => 'Password not match';

  @override
  String get settings => 'Settings';

  @override
  String get themeLight => 'Theme Light';

  @override
  String get themeDark => 'Theme Dark';

  @override
  String get errorNoData => 'No data';

  @override
  String get logout => 'Logout';

  @override
  String get logoutDesc => 'Do you want to logout from the app?';

  @override
  String get yes => 'Yes';
}
