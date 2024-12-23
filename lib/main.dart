import 'package:delivery_app_new/core/api/dio_consumer.dart';
import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/core/routes/app_routes.dart';
import 'package:delivery_app_new/core/service/servise_locator.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CashHelper>().init();
  return runApp(
    BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio())),
      child: const DeliveryApp(),
    ),
  );
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.afwait,
        useMaterial3: true,
        fontFamily: 'Parkinsans',
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
