import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  // Initialize cache
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Get data as String
  String? getDataString({required String key}) {
    print("Getting data for key: $key");
    return sharedPreferences.getString(key);
  }

  // Save data to local database with a key
  Future<bool> saveData({required String key, required dynamic value}) async {
    print("Saving data: $value with key: $key");
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }

  // Future<bool> saveData({required String key, required dynamic value}) async {
  //   if (value is String) {
  //     return await sharedPreferences.setString(key, value);
  //   } else {
  //     throw Exception("Unsupported value type for key: $key");
  //   }
  // }

  // Get data already saved in local database
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Remove data with a specific key
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // Check if local database contains the key
  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  // Clear all data in the local database
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  // Put data in local database with a key
  Future<bool> put({required String key, required dynamic value}) async {
    print("Putting data: $value with key: $key");
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    throw Exception("Unsupported type");
  }
}
