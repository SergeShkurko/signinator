import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  RegisterStoreBase(this._postRegister);

  final PostRegister _postRegister;

  final StreamController<NotificationDetails> _notificationStreamController =
      StreamController<NotificationDetails>();

  final RegisterFormErrorState error = RegisterFormErrorState();

  @observable
  late ObservableStream<NotificationDetails?> notifications = ObservableStream(
      _notificationStreamController.stream.asBroadcastStream());

  @observable
  String name = '';

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
      reaction((_) => name, validateUsername),
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validateUsername(String value) {
    if (value.isEmpty) {
      error.username = 'Cannot be blank';
      return;
    }

    error.username = null;
  }

  @action
  void validatePassword(String value) {
    error.password = value.isEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validateEmail(String value) {
    error.email = value.contains('@') ? null : 'Not a valid email';
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
    validateUsername(name);
  }

  Future<bool> register() async {
    validateAll();

    if (!error.hasErrors) {
      final data = await _postRegister.call(RegisterParams(
        email: email,
        password: password,
      ));
      return data.fold<bool>(
        (l) {
          if (l is ServerFailure) {
            _notificationStreamController
                .add(NotificationDetails.success(l.message ?? ""));
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
class RegisterFormErrorState = _RegisterFormErrorState
    with _$RegisterFormErrorState;

abstract class _RegisterFormErrorState with Store {
  @observable
  String? username;

  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => username != null || email != null || password != null;
}
