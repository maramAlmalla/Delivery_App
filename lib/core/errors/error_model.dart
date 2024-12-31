import 'package:delivery_app_new/core/api/end_points.dart';

class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errorMessage: jsonData[ApiKey.errorMessage],
    );
  }
}
