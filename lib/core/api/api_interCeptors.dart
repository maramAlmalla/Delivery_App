import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Accept': 'application/json',
    });

    options.headers[ApiKey.token] =
        CashHelper().getData(key: ApiKey.token) != null
            ? 'FOODAPI ${CashHelper().getData(key: ApiKey.token)}'
            : null;

    super.onRequest(options, handler);
  }
}
