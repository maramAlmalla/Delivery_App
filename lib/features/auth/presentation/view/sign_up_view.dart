import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/widget/custom_button.dart';
import 'package:delivery_app_new/core/widget/custom_text_field.dart';
import 'package:delivery_app_new/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
import 'package:delivery_app_new/features/auth/presentation/widget/sign_up_widgets/header_section_up.dart';
import 'package:delivery_app_new/features/auth/presentation/widget/sign_up_widgets/sign_in_redirct.dart';
import 'package:delivery_app_new/features/auth/presentation/widget/sign_up_widgets/terms_privacy_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController signUpFirstName = TextEditingController();
  final TextEditingController signUpLastName = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    signUpFirstName.dispose();
    signUpLastName.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final firstName = signUpFirstName.text.trim();
      final lastName = signUpLastName.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();

      context.read<UserCubit>().signUp(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          CustomNavigationReplacement(context, '/Main');
          context.read<UserCubit>().getUserProfile();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMessage),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const HeaderSection(),
                      Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: "First Name",
                              controller: signUpFirstName,
                              icon:
                                  const Icon(Icons.person, color: Colors.grey),
                              color: Colors.white,
                              textColor: Colors.black,
                              label: "First Name",
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: "Last Name",
                              controller: signUpLastName,
                              icon:
                                  const Icon(Icons.person, color: Colors.grey),
                              color: Colors.white,
                              textColor: Colors.black,
                              label: "Last Name",
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: "Phone Number",
                              controller: phoneNumberController,
                              icon: const Icon(Icons.phone, color: Colors.grey),
                              color: Colors.white,
                              textColor: Colors.black,
                              label: "Phone Number",
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: "Email Address",
                              controller: emailController,
                              icon: const Icon(Icons.email, color: Colors.grey),
                              color: Colors.white,
                              textColor: Colors.black,
                              label: "Email",
                              obscureText: false,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: "Password",
                              controller: passwordController,
                              icon: const Icon(Icons.lock, color: Colors.grey),
                              color: Colors.white,
                              textColor: Colors.black,
                              label: "Password",
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Column(
                          children: [
                            const TermsAndPrivacyRow(),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: 'Sign Up',
                              color: AppColors.darkTealBlue,
                              onTap: () {
                                _signUp(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SignInRedirect(),
                    ],
                  ),
                ),
              ),
              if (state is SignUpLoading)
                Container(
                  color: const Color(0xff1A2E35).withOpacity(0.7),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColors.tealGreen),
                        const SizedBox(height: 20),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            color: AppColors.tealGreen,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
