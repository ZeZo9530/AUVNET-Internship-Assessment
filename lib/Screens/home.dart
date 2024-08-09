import 'package:flutter/material.dart';
import 'package:store_app/Screens/all_products.dart';
import 'package:store_app/Screens/order_history.dart';
import 'package:store_app/Screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "homeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//the 3 main screens of the app in the bottom nav bar
class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  final List _screens = [
    {
      "screen": const ProductsPage(),
    },
    {
      "screen": const OrderScreen(),
    },
    {
      "screen": const ProfileScreen(),
    },
  ];

  void _selectScreen(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[screenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: screenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_edu_rounded), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
