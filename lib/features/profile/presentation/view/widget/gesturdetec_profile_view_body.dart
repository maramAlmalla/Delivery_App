import 'package:delivery_app_new/core/utils/app_text_Style.dart';
import 'package:flutter/material.dart';

class GestureDetecProfileViewBody extends StatelessWidget {
  const GestureDetecProfileViewBody(
      {super.key,
      required this.iconc,
      required this.title,
      required this.subTitle,
      required this.onTap});
  final Icon iconc;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
        child: ListTile(
            leading: iconc,
            title: Text(title,
                style: CustomTextStyle.parkinsans400Style12
                    .copyWith(fontWeight: FontWeight.bold)),
            subtitle: Text(subTitle,
                style: CustomTextStyle.parkinsans400Style12
                    .copyWith(fontSize: 13, color: Colors.grey)),
            onTap: onTap),
      ),
    );
  }
}
