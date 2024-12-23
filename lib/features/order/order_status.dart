import 'package:delivery_app_new/core/utils/app_assets.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final String status;

  const OrderStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String message = '';
    String image = '';
    Widget? actionButton;

    Color backgroundColor = AppColors.afwait;
    Color buttonColor = AppColors.goldenOrange;
    TextStyle buttonTextStyle = CustomTextStyle.parkinsans500Style24
        .copyWith(fontWeight: FontWeight.w300, color: AppColors.afwait);

    switch (status) {
      case 'pending':
        message = 'Your order is pending approval.';
        image = Assets.pending;
        actionButton = ElevatedButton(
          onPressed: () {
            // Action for cancelling
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Cancel Order',
            style: buttonTextStyle,
          ),
        );
        break;

      case 'active':
        message = 'Your order is being processed.';
        image = Assets.active;
        break;

      case 'done':
        message = 'Your order has been completed!';
        image = Assets.done;
        actionButton = ElevatedButton(
          onPressed: () {
            // Action for rating
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Rate Order',
            style: buttonTextStyle,
          ),
        );
        break;

      case 'canceled':
        message = 'Your order has been cancelled.';
        image = Assets.canceled;
        break;

      default:
        message = 'Unknown order status.';
        image = 'assets/image/noData.png';
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.darkTealBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.afwait,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Order Status',
            style: CustomTextStyle.parkinsans500Style24.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTealBlue,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),
            Text(
              message,
              style: CustomTextStyle.parkinsans400Style22.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 200),
            if (actionButton != null) actionButton,
          ],
        ),
      ),
    );
  }
}
