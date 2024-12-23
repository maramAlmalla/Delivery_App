import 'package:delivery_app_new/core/utils/app_colors.dart';
import 'package:delivery_app_new/features/favorite/presentation/view/fav_view.dart';
import 'package:delivery_app_new/features/home/presentation/view/home_view.dart';
import 'package:delivery_app_new/features/markets/presentation/view/markets_view.dart';
import 'package:delivery_app_new/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.afwait,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // لمتابعة الصفحة الحالية

  // قائمة الشاشات للتنقل بينها
  final List<Widget> _screens = [
    HomeView(),
    MarketsView(),
    FavoriteView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.afwait,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(26),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.darkTealBlue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.tealGreen.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home, index: 0),
            _buildNavItem(icon: Icons.list, index: 1),
            _buildNavItem(icon: Icons.favorite_border, index: 2),
            _buildNavItem(icon: Icons.person_outline, index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Icon(
        icon,
        color: _currentIndex == index ? AppColors.tealGreen : Colors.grey[400],
        size: 28,
      ),
    );
  }
}
