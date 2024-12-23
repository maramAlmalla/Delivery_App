import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/app_bar_container_edit_profile.dart';
import 'package:delivery_app_new/features/profile/presentation/view/widget/edit_profile_body.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  final String email;
  final String? role;

  const EditProfileView({
    super.key,
    required this.email,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBarContainerEditProfile(
            title: 'Edit Profile',
            onPressed: () {
              CustomNavigationReplacement(context, '/profileView');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          EditProfileBody(
            email: email,
            role: role!,
          ),
        ])));
  }
}
