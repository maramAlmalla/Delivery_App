// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:delivery_app/core/widget/cusstom_text_field.dart';
// import 'package:delivery_app/features/auth/presentation/view_model/cubits/cubit/user_cubit.dart';

// class EmailAndPasswordFields extends StatelessWidget {
//   const EmailAndPasswordFields({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<UserCubit>();

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: CustomTextField(
//             controller: cubit.signInEmail,
//             label: 'Email or Phone',
//             labelColor: Colors.grey,
//             hintText: 'Email or Phone',
//             textColor: Colors.grey,
//             onChanged: (value) {
//               // تحديث القيم في Cubit باستخدام القيمة المدخلة
//               cubit.updateEmail(
//                   value); // value هنا هي النص المدخل في الـ TextField
//             },
//             icon: const Icon(Icons.person, color: Colors.grey),
//             color: const Color(0xff1A2E35),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: CustomTextField(
//             controller: cubit.signInPassword,
//             label: 'Password',
//             labelColor: Colors.grey,
//             hintText: 'Password',
//             textColor: Colors.grey,
//             onChanged: (value) {
//               // تحديث القيم في Cubit باستخدام القيمة المدخلة
//               cubit.updatePassword(
//                   value); // value هنا هي النص المدخل في الـ TextField
//             },
//             icon: const Icon(Icons.lock, color: Colors.grey),
//             color: const Color(0xff1A2E35),
//           ),
//         ),
//       ],
//     );
//   }
// }
