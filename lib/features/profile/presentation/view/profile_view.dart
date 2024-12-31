import 'package:delivery_app_new/core/database/cache/cache_helper.dart';
import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/app_bar_container_edit_profile.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/id_profile_user.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final token = CacheHelper().getDataString(key: 'token');
    if (token == null || token.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return _buildErrorDialog(context);
          },
        );
      });
      return const SizedBox.shrink();
    }
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is GetUserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetUserSuccess) {
            final user = state.userModel;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarContainerEditProfile(
                    title: 'Profile User',
                    onPressed: () {
                      CustomNavigationReplacement(context, '/Main');
                    },
                  ),
                  IdProfileUser(
                    userName: "${user.name} ${user.lastName}",
                    subTitle: user.email,
                    imageUrl: user.img!,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "General",
                      style: CustomTextStyle.parkinsans400Style12.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const ProfileViewBody(),
                ],
              ),
            );
          } else if (state is GetUserFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return _buildErrorDialog(context);
                },
              );
            });
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorDialog(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Account Error',
              style: CustomTextStyle.parkinsans500Style24
                  .copyWith(color: AppColors.goldenOrange)),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.darkTealBlue),
            onPressed: () {
              // CustomNavigationReplacement(context, '/Main');
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Text("No account found. Please register or log in.",
          style: CustomTextStyle.parkinsans300Style16
              .copyWith(fontWeight: FontWeight.w600)),
      actions: [
        TextButton(
          onPressed: () {
            CustomNavigationReplacement(context, '/SignUpView');
          },
          child: Text(
            "Register",
            style: CustomTextStyle.parkinsans300Style16
                .copyWith(color: AppColors.goldenOrange),
          ),
        ),
        TextButton(
          onPressed: () {
            CustomNavigationReplacement(context, '/SignInView');
          },
          child: Text(
            "Log In",
            style: CustomTextStyle.parkinsans300Style16
                .copyWith(color: AppColors.goldenOrange),
          ),
        ),
      ],
    );
  }
}
