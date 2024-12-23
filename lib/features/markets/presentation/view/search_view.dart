import 'dart:ui';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.darkTealBlue,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: AppColors.darkTealBlue.withOpacity(0.6),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: searchController,
                  cursorColor: AppColors.tealGreen,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    // hoverColor: AppColors.tealGreen,

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.tealGreen,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.tealGreen,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                child: Center(
                  child: Text(
                    'Search Suggestions Appear Here',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
