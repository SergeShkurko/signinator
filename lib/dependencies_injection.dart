import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signinator/core/core.dart';
import 'package:signinator/features/features.dart';
import 'package:signinator/utils/utils.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  /// For unit testing only
  if (isUnitTest) {
    WidgetsFlutterBinding.ensureInitialized();
    sl.reset();
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance().then((value) {
      initPrefManager(value);
    });
    sl.registerSingleton<DioClient>(DioClient(isUnitTest: true));
    dataSources();
    repositories();
    useCase();
    cubit();
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    dataSources();
    repositories();
    useCase();
    cubit();
  }
}

// Register prefManager
void initPrefManager(SharedPreferences initPrefManager) {
  sl.registerLazySingleton<PrefManager>(() => PrefManager(initPrefManager));
}

/// Register repositories
void repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
}

/// Register dataSources
void dataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl()),
  );
}

void useCase() {
  /// Auth
  sl.registerLazySingleton(() => IsLoggedIn(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));
}

void cubit() {
  /// Auth
  sl.registerFactory(() => RegisterStore(sl()));
  sl.registerFactory(() => LoginStore(sl()));
  sl.registerFactory(() => AuthStore(sl(), sl()));
}
