import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:delivery_app_new/features/profile/presentation/view/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdProfileUser extends StatelessWidget {
  const IdProfileUser({
    super.key,
    required this.userName,
    required this.subTitle,
    required this.imageUrl,
  });

  final String userName;
  final String subTitle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(imageUrl),
                  onBackgroundImageError: (_, __) {
                    print('Failed to load image');
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName,
                          style: CustomTextStyle.parkinsans500Style24
                              .copyWith(fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subTitle,
                          style: CustomTextStyle.parkinsans300Style16
                              .copyWith(color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    final userCubit = BlocProvider.of<UserCubit>(context);
                    final user = (userCubit.state as GetUserSuccess).userModel;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(
                          email: user.email,
                          role: user.role,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit, color: AppColors.goldenOrange),
                  label: Text(
                    'Edit',
                    style: TextStyle(color: AppColors.goldenOrange),
                  ),
                ),
              ],
            )));
  }
}
