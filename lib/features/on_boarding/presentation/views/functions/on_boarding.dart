import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/core/service/servise_locator.dart';

void onBoardingVisited() {
  getIt<CacheHelper>().saveData(key: "isOnBoardingVisited", value: true);
}
