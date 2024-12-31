import 'package:delivery_app_new/core/function/navigation.dart';
import 'package:delivery_app_new/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app_new/features/search/models/search_card_market.dart';
import 'package:delivery_app_new/core/utils/app_colors.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;

  const SearchResultsPage({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.afwait),
          onPressed: () {
            CustomNavigationReplacement(context, '/Main');
          },
        ),
        title: Text(
          "Search Results",
          style: CustomTextStyle.parkinsans500Style24.copyWith(
            color: AppColors.tealGreen,
            fontSize: 25,
          ),
        ),
        backgroundColor: AppColors.darkTealBlue,
      ),
      body: searchResults.isEmpty
          ? const Center(child: Text("No markets found."))
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final market = searchResults[index];
                return SearchCardMarket(market: market);
              },
            ),
    );
  }
}
