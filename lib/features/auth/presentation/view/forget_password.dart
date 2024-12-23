import 'package:delivery_app_new/features/auth/presentation/widget/container_to_lock_view.dart';
import 'package:delivery_app_new/features/auth/presentation/widget/start_page_lock.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                StartPageLock(),
              ],
            ),
            SizedBox(height: 50),
            ContainertoLockView(),
          ],
        ),
      ),
    );
  }
}
