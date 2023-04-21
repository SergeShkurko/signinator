import 'package:dartz/dartz.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';

class IsLoggedIn extends UseCase<bool, void> {
  final AuthRepository _repo;

  IsLoggedIn(this._repo);

  @override
  Future<Either<Failure, bool>> call(void params) => _repo.isLoggedIn;
}
