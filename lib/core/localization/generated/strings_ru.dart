import 'strings.dart';

/// The translations for Russian (`ru`).
class StringsRu extends Strings {
  StringsRu([String locale = 'ru']) : super(locale);

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
  String get signOut => 'Выход';

  @override
  String get failed => 'Ошибка!';

  @override
  String get succeed => 'Успех!';

  @override
  String get loremIpsum => 'Чтобы добиться успеха в жизни нужно только... :)';
}
