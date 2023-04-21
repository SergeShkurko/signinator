import 'package:dartz/dartz.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  /// Data Source
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  const AuthRepositoryImpl(this.authRemoteDatasource, this.authLocalDatasource);

  @override
  Future<Either<Failure, bool>> get isLoggedIn async =>
      await authLocalDatasource.isLoggedIn;

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    final response = await authRemoteDatasource.login(loginParams);

    return response.fold(
      (failure) => Left(failure),
      (loginResponse) {
        authLocalDatasource.signIn(loginResponse);
        return Right(loginResponse.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, Register>> register(
    RegisterParams registerParams,
  ) async {
    final response = await authRemoteDatasource.register(registerParams);

    return response.fold(
      (failure) => Left(failure),
      (registerResponse) {
        authLocalDatasource.signIn(registerResponse);
        return Right(registerResponse.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, void>> logout() async =>
      await authLocalDatasource.signOut();
}
