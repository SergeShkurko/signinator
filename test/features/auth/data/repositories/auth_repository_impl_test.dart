import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/dependencies_injection.dart';
import 'package:signinator/features/features.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/test_mock.mocks.dart';

void main() {
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late MockAuthLocalDatasource mockAuthLocalDatasource;
  late AuthRepositoryImpl authRepositoryImpl;
  late Login login;
  late Register register;

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    authRepositoryImpl =
        AuthRepositoryImpl(mockAuthRemoteDatasource, mockAuthLocalDatasource);
    login = LoginResponse.fromJson(
      json.decode(jsonReader(successLoginPath)) as Map<String, dynamic>,
    ).toEntity();
    register = RegisterResponse.fromJson(
      json.decode(jsonReader(successRegisterPath)) as Map<String, dynamic>,
    ).toEntity();
  });

  group("login", () {
    const loginParams = LoginParams(email: "email", password: "password");
    final successResponse = LoginResponse.fromJson(
      json.decode(jsonReader(successLoginPath)) as Map<String, dynamic>,
    );
    test('should return login when call data is successful', () async {
      // arrange
      when(mockAuthLocalDatasource.signIn(successResponse)).thenAnswer(
        (_) async => const Right(null),
      );
      when(mockAuthRemoteDatasource.login(loginParams)).thenAnswer(
        (_) async => Right(successResponse),
      );

      // act
      final result = await authRepositoryImpl.login(loginParams);

      // assert
      verify(mockAuthRemoteDatasource.login(loginParams));

      expect(result, Right(login));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDatasource.login(loginParams))
            .thenAnswer((_) async => const Left(ServerFailure('')));

        // act
        final result = await authRepositoryImpl.login(loginParams);

        // assert
        verify(mockAuthRemoteDatasource.login(loginParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group("register", () {
    const registerParams = RegisterParams(email: "email", password: "password");
    final successResponse = RegisterResponse.fromJson(
      json.decode(jsonReader(successRegisterPath)) as Map<String, dynamic>,
    );
    test('should return register when call data is successful', () async {
      // arrange
      when(mockAuthLocalDatasource.signIn(successResponse)).thenAnswer(
        (_) async => const Right(null),
      );
      when(mockAuthRemoteDatasource.register(registerParams)).thenAnswer(
        (_) async => Right(successResponse),
      );

      // act
      final result = await authRepositoryImpl.register(registerParams);

      // assert
      verify(mockAuthRemoteDatasource.register(registerParams));
      expect(result, equals(Right(register)));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockAuthRemoteDatasource.register(registerParams))
            .thenAnswer((_) async => const Left(ServerFailure('')));

        // act
        final result = await authRepositoryImpl.register(registerParams);

        // assert
        verify(mockAuthRemoteDatasource.register(registerParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });
}
