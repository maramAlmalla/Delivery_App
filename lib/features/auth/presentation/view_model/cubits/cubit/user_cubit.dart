import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delivery_app_new/core/api/api_conSumer.dart';
import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/core/errors/exCeptions.dart';
import 'package:delivery_app_new/features/auth/presentation/models/signIn_model.dart';
import 'package:delivery_app_new/features/auth/presentation/models/signup_model.dart';
import 'package:delivery_app_new/features/profile/presentation/models/user_model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;

  // Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  // Profile Pic
  XFile? profilePic;
  // Sign up first name
  TextEditingController signUpFirstName = TextEditingController();

  TextEditingController signUpLastName = TextEditingController();

  // Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  // Sign up email
  TextEditingController signUpEmail = TextEditingController();
  // Sign up password
  TextEditingController signUpPassword = TextEditingController();
  // Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  SignInModel? user;
  SignUpModel? signUpUser;

// ___________________SignUp_______________

  signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(SignUpLoading());

      final response = await api.post(
        EndPoint.baseUrl + EndPoint.signUp,
        isFromData: true,
        data: {
          "name": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
        },
      );

      print("Response Data: $response");

      signUpUser = SignUpModel.fromJson(response);

      if (signUpUser?.token == null || signUpUser!.token!.isEmpty) {
        throw Exception("Token is empty or null");
      }

      final token = signUpUser!.token!;
      final userId = response['user']['id'];

      await CashHelper().saveData(key: 'token', value: token);
      await CashHelper().saveData(key: 'userId', value: userId);

      print("Token saved: $token");

      emit(SignUpSuccess(message: signUpUser!.message));
      final storedToken = CashHelper().getDataString(key: 'token');
      print("Stored Token: $storedToken");
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      print("Error: $e");
      emit(SignUpFailure(
          errMessage: "Unexpected error occurred. Please try again."));
    }
  }

//___________________________SignIn________________________
  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(SignInLoading());

      final response = await api.post(
        EndPoint.baseUrl + EndPoint.signIn,
        data: {'identifier': email, 'password': password},
      );

      if (response['token'] == null || response['token'].isEmpty) {
        emit(SignInFailure(errMessage: "Invalid credentials or empty token."));
        return;
      }

      user = SignInModel.fromJson(response);

      final token = user!.token;
      final userId = response['userId'];

      await CashHelper().saveData(key: 'token', value: token);
      await CashHelper().saveData(key: 'userId', value: userId);

      emit(SignInSuccess());
    } on DioException catch (e) {
      emit(SignInFailure(errMessage: "Connection failed: ${e.message}"));
    } catch (e) {
      emit(SignInFailure(errMessage: "Unexpected error occurred: $e"));
    }
  }
//__________________get profile _________________

  Future<void> getUserProfile() async {
    try {
      emit(GetUserLoading());

      final userId = CashHelper().getData(key: 'userId');
      if (userId == null) {
        emit(GetUserFailure(errMessage: "User ID not found"));
        return;
      }

      final response = await api.get(
        EndPoint.baseUrl + EndPoint.getUserDataEndPoint(userId),
      );

      print("User Profile Response: $response");

      final userModel = UserModel.fromJson(response);
      emit(GetUserSuccess(userModel: userModel));
    } catch (e) {
      print("Error fetching user profile: $e");
      emit(GetUserFailure(errMessage: "Failed to load user profile."));
    }
  }

  //__________________update user  _________________

  Future<void> updateUserProfile({
    required Map<String, dynamic> updatedData,
    File? imageFile,
  }) async {
    try {
      emit(UpdateUserLoading());

      final userId = CashHelper().getData(key: 'userId');
      if (userId == null) {
        emit(UpdateUserFailure(errMessage: "User ID not found"));
        return;
      }

      FormData formData = FormData.fromMap(updatedData);
      if (imageFile != null) {
        formData.files.add(MapEntry(
          'img',
          await MultipartFile.fromFile(imageFile.path, filename: 'profile.jpg'),
        ));
      }

      final response = await api.post(
        EndPoint.baseUrl + EndPoint.updateUserDataEndPoint(userId),
        data: formData,
      );

      print("Update Response: $response");

      final userJson = response['user'];
      if (userJson == null) {
        throw Exception("User data is null");
      }

      final userModel = UserModel(
        id: userJson['id'] ?? -1,
        name: userJson['name'] ?? 'Unknown',
        email: userJson['email'] ?? 'No Email',
        lastName: userJson['lastName'] ?? 'no lastname',
        phoneNumber: userJson['phoneNumber'] ?? 'no phone number',
      );

      emit(UpdateUserSuccess(userModel: userModel));
    } catch (e) {
      print("Error updating user profile: $e");
      emit(UpdateUserFailure(errMessage: "Failed to update user profile."));
    }
  }

  //________log out _____________________

  Future<void> logout() async {
    try {
      emit(LogoutLoading());

      final token = CashHelper().getDataString(key: 'token');
      if (token == null || token.isEmpty) {
        emit(LogoutFailure(errMessage: "No token found."));
        return;
      }

      await api.post(
        EndPoint.baseUrl + EndPoint.logout,
        headers: {'Authorization': 'Bearer $token'},
      );

      await CashHelper().clearData();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(errMessage: "Failed to log out: $e"));
    }
  }
}
