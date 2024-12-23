import 'package:delivery_app_new/features/auth/presentation/widget/Custom_text_field_2.dart';
import 'package:flutter/material.dart';

class InputFieldsSection extends StatelessWidget {
  const InputFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<UserCubit>();
    return const Column(
      children: [
        CustomTextField2(
          hintText: "First Name",
          icon: Icon(Icons.person, color: Colors.grey),
          color: Colors.white,
          textColor: Colors.black,
          label: "First Name",
          obscureText: false,
        ),
        CustomTextField2(
          hintText: "Last Name",
          icon: Icon(Icons.person, color: Colors.grey),
          color: Colors.white,
          textColor: Colors.black,
          label: "Last Name",
          obscureText: false,
        ),
        SizedBox(height: 10),
        CustomTextField2(
          hintText: "Email Address",
          icon: Icon(Icons.email, color: Colors.grey),
          color: Colors.white,
          textColor: Colors.black,
          label: "Email",
          obscureText: false,
        ),
        SizedBox(height: 10),
        CustomTextField2(
          hintText: "Password",
          icon: Icon(Icons.lock, color: Colors.grey),
          color: Colors.white,
          textColor: Colors.black,
          label: "Password",
          obscureText: true,
        ),
        SizedBox(height: 10),
        CustomTextField2(
          hintText: "Retype Password",
          icon: Icon(Icons.lock, color: Colors.grey),
          color: Colors.white,
          textColor: Colors.black,
          label: "Confirm Password",
          obscureText: true,
        ),
      ],
    );
  }
}
