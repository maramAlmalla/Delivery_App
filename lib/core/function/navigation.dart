import 'package:go_router/go_router.dart';

// ignore: non_constant_identifier_names
void CustomNavigation(context, String path) {
  GoRouter.of(context).push(path);
}

// ignore: non_constant_identifier_names
void CustomNavigationReplacement(context, String path) {
  GoRouter.of(context).pushReplacement(path);
}
