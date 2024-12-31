// import 'package:delivery_app_new/core/api/end_points.dart';
// import 'package:delivery_app_new/features/search/view/search_resaults_view.dart';
// import 'package:dio/dio.dart';
// import 'package:delivery_app_new/core/utils/app_colors.dart';
// import 'package:flutter/material.dart';

// class SearchProductView extends StatefulWidget {
//   const SearchProductView({super.key});

//   @override
//   _SearchProductViewState createState() => _SearchProductViewState();
// }

// class _SearchProductViewState extends State<SearchProductView> {
//   final TextEditingController searchController = TextEditingController();
//   bool isLoading = false;

//   Future<void> searchProducts(BuildContext context) async {
//     final searchQuery = searchController.text.trim();
//     if (searchQuery.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a search term!")),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final dio = Dio();
//       final response = await dio.get(
//         '${EndPoint.baseUrl}products',
//         queryParameters: {'search': searchQuery},
//       );

//       print("Response data: ${response.data}");

//       if (response.statusCode == 200) {
//         final results = (response.data['data'] as List<dynamic>? ?? []);
//         print("Results fetched: $results");

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SearchResultsPage(
//               searchResults: results.cast<Map<String, dynamic>>(),
//             ),
//           ),
//         );
//       } else {
//         print("Error: Status code ${response.statusCode}");
//       }
//     } catch (e, stackTrace) {
//       print("Error fetching data: $e");
//       print("StackTrace: $stackTrace");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error fetching search results.")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: AppColors.darkTealBlue,
//           ),
//           Column(
//             children: [
//               const SizedBox(height: 70),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextField(
//                         controller: searchController,
//                         cursorColor: AppColors.tealGreen,
//                         decoration: InputDecoration(
//                           hintText: 'Search products...',
//                           prefixIcon:
//                               const Icon(Icons.search, color: Colors.black),
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: AppColors.tealGreen, width: 1),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: AppColors.tealGreen, width: 2.5),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         onSubmitted: (text) {
//                           searchProducts(context);
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (isLoading)
//                 const Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: CircularProgressIndicator(),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
