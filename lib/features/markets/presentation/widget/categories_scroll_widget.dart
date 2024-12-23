import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CategoriesScrollWidget extends StatefulWidget {
  final Axis scrollDirection;
  final bool showOuterContainer;
  const CategoriesScrollWidget({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.showOuterContainer = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesScrollWidgetState createState() => _CategoriesScrollWidgetState();
}

class _CategoriesScrollWidgetState extends State<CategoriesScrollWidget> {
  List<Map<String, dynamic>> categories = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      print('Fetching categories...');
      final dio = Dio();
      final response =
          await dio.get('http://192.168.43.59:8000/api/categories');
      print('Response received: ${response.data}');
      print(response.statusCode);

      final data = response.data['data'] as List;

      setState(() {
        categories = data
            .map((item) => {
                  'name': item['name'],
                  'img': item['img'],
                })
            .toList();
        print('Parsed categories: $categories');
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showOuterContainer) {
      return SizedBox(
        width:
            widget.scrollDirection == Axis.horizontal ? double.infinity : 100,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tealGreen,
            borderRadius: widget.scrollDirection == Axis.vertical
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : null,
          ),
          height: widget.scrollDirection == Axis.horizontal ? 150 : 400,
          child: buildListView(),
        ),
      );
    } else {
      return SizedBox(
        height: widget.scrollDirection == Axis.horizontal ? 150 : 400,
        child: buildListView(),
      );
    }
  }

  Widget buildListView() {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            scrollDirection: widget.scrollDirection,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: widget.scrollDirection == Axis.horizontal
                    ? const EdgeInsets.symmetric(horizontal: 8.0)
                    : const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
                  onTap: () {
                    print('Selected Category: ${category['name']}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              category['img'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (widget.scrollDirection == Axis.vertical)
                        const SizedBox(height: 18),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
