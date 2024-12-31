import 'dart:ui';
import 'package:delivery_app_new/core/api/end_points.dart';
import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/features/search/view/search_resaults_market_view.dart';
import 'package:dio/dio.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchMarketView extends StatefulWidget {
  SearchMarketView({super.key});

  @override
  _SearchMarketViewState createState() => _SearchMarketViewState();
}

class _SearchMarketViewState extends State<SearchMarketView> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  Future<void> searchMarkets(BuildContext context) async {
    final searchQuery = searchController.text.trim();
    if (searchQuery.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final dio = Dio();
      final response = await dio.get(
        '${EndPoint.baseUrl}markets',
        queryParameters: {'search': searchQuery},
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultsPage(
              searchResults:
                  List<Map<String, dynamic>>.from(response.data['data']),
            ),
          ),
        );
      }
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          CustomNavigationReplacement(context, '/Main');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorColor: AppColors.tealGreen,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.tealGreen, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.tealGreen, width: 2.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (text) {
                          searchMarkets(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
