// import 'package:delivery_app/core/function/navigation.dart';
// import 'package:delivery_app/core/utils/app_colors.dart';
// import 'package:delivery_app/core/widget/custom_button.dart';
// import 'package:delivery_app/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BottomContainer extends StatelessWidget {
//   const BottomContainer({super.key});

//   void navigateToForgotPassword(BuildContext context) {
//     CustomNavigation(context, '/ForgetPasswordView');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(50),
//           topRight: Radius.circular(50),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               navigateToForgotPassword(context);
//             },
//             child: const Text(
//               'Forgot Password?',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Parkinsans',
//                 fontSize: 15,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//           const SizedBox(height: 32),
//           CustomButton(
//             onTap: () {
//               print("Login button pressed");
//               context.read<UserCubit>().testApi();
//             },
//             text: 'Login',
//             color: AppColors.tealGreen,
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'or',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Parkinsans',
//             ),
//           ),
//           const SizedBox(height: 12),
//           CustomButton(
//             onTap: () {
//               CustomNavigationReplacement(context, '/SignUpView');
//             },
//             text: 'Create an Account',
//             color: AppColors.tealGreen,
//           ),
//         ],
//       ),
//     );
//   }
// }
