import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase(this._postLogin);

  final PostLogin _postLogin;

  final StreamController<NotificationDetails> _notificationStreamController =
      StreamController<NotificationDetails>();

  final LoginFormErrorState error = LoginFormErrorState();

  @observable
  late ObservableStream<NotificationDetails?> notifications = ObservableStream(
      _notificationStreamController.stream.asBroadcastStream());

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isPasswordHide = true;

  @computed
  bool get canLogin => !error.hasErrors;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validatePassword(String value) {
    error.password = value.isEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validateEmail(String value) {
    error.email = value.isEmpty ? 'Cannot be blank' : null;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
    _notificationStreamController.close();
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
  }

  Future<bool> login() async {
    validateAll();

    if (!error.hasErrors) {
      final data = await _postLogin.call(LoginParams(
        email: email,
        password: password,
      ));
      return data.fold<bool>(
        (l) {
          if (l is ServerFailure) {
            _notificationStreamController
                .add(NotificationDetails.error(l.message));
          }
          return false;
        },
        (r) {
          _notificationStreamController.add(NotificationDetails.success());
          return true;
        },
      );
    }
    return false;
  }
}

// ignore: library_private_types_in_public_api
class LoginFormErrorState = _LoginFormErrorState with _$LoginFormErrorState;

abstract class _LoginFormErrorState with Store {
  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => email != null || password != null;
}
