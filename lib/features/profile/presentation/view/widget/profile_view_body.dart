import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/gesturdetec_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/Main');
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.errMessage}")),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            GestureDetecProfileViewBody(
              iconc: const Icon(Icons.notifications),
              title: "Notification",
              subTitle: 'Recent Message, tone',
              onTap: () {},
            ),
            GestureDetecProfileViewBody(
              iconc: const Icon(Icons.list_alt),
              title: "Orders",
              subTitle: 'All order, Pre_order',
              onTap: () {},
            ),
            GestureDetecProfileViewBody(
              iconc: const Icon(Icons.language),
              title: "Language",
              subTitle: 'English (device language)',
              onTap: () {},
            ),
            GestureDetecProfileViewBody(
              iconc: const Icon(Icons.payment),
              title: "Billing Payment",
              subTitle: 'Payment method',
              onTap: () {},
            ),
            GestureDetecProfileViewBody(
              iconc: const Icon(Icons.logout),
              title: "Log Out",
              subTitle: 'Log out of the account',
              onTap: () => _showLogoutConfirmation(context),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Confirm Logout",
            style: CustomTextStyle.parkinsans500Style24
                .copyWith(color: AppColors.darkTealBlue),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: CustomTextStyle.parkinsans400Style16,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel",
                  style: CustomTextStyle.parkinsans400Style16),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserCubit>().logout();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/Main');
              },
              child: Text(
                "Logout",
                style: CustomTextStyle.parkinsans400Style16
                    .copyWith(color: AppColors.goldenOrange),
              ),
            ),
          ],
        );
      },
    );
  }
}
