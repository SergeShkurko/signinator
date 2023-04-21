import 'package:dartz/dartz.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> get isLoggedIn;

  Future<Either<Failure, Login>> login(LoginParams loginParams);

  Future<Either<Failure, Register>> register(RegisterParams registerParams);

  Future<Either<Failure, void>> logout();
}
