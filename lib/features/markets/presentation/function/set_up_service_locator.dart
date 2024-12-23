import 'package:delivery_app_new/features/markets/presentation/data/api_service_category.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // تسجيل Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  // تسجيل ApiService
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));
}
