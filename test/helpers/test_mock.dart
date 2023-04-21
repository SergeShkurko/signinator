import 'package:mockito/annotations.dart';
import 'package:signinator/features/features.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDatasource,
  AuthLocalDatasource,
])
void main() {}
