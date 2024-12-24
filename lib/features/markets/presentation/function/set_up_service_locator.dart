import 'package:delivery_app_new/features/markets/presentation/data/api_service_category.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));
}
