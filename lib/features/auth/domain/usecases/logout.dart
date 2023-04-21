import 'package:dartz/dartz.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

class Logout extends UseCase<void, void> {
  final AuthRepository _repo;

  Logout(this._repo);

  @override
  Future<Either<Failure, void>> call(void params) => _repo.logout();
}
