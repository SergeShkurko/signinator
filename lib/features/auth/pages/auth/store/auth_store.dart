import 'package:mobx/mobx.dart';
import 'package:signinator/features/features.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase(this._isLoggedIn, this._logout) {
    check();
  }

  final IsLoggedIn _isLoggedIn;
  final Logout _logout;

  @observable
  bool isLoggedIn = false;

  @action
  Future<void> check() async {
    final result = await _isLoggedIn.call(null);
    isLoggedIn = result.fold<bool>((l) => false, (r) => r);
  }

  @action
  void login() {
    isLoggedIn = true;
  }

  @action
  void logout() {
    _logout.call(null);
    isLoggedIn = false;
  }
}
