import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<CashHelper>(CashHelper());
}
