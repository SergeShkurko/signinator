import 'package:dartz/dartz.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/auth/auth.dart';
import 'package:signinator/utils/utils.dart';

abstract class AuthLocalDatasource {
  Future<Either<Failure, void>> signIn(
    TokenResponse tokenResponse,
  );

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, bool>> get isLoggedIn;
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final PrefManager _manager;

  AuthLocalDatasourceImpl(this._manager);

  @override
  Future<Either<Failure, void>> signIn(TokenResponse tokenResponse) async {
    try {
      _manager.isLogin = true;
      _manager.token = tokenResponse.token;
      return const Right(null);
    } catch (error) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      _manager.isLogin = false;
      _manager.token = '';
      return const Right(null);
    } catch (error) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> get isLoggedIn async {
    try {
      return Right(_manager.isLogin);
    } catch (error) {
      return Left(CacheFailure());
    }
  }
}
