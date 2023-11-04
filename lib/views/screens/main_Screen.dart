import 'package:bungkus_bang/views/screens/widgets/store_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'account_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    StoreScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 56, 176, 157),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/store-1.png',
              fit: BoxFit.cover,
              width: 20,
            ),
            label: 'VENDOR',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/shopping-bag-icon.svg',
              fit: BoxFit.cover,
              width: 20,
            ),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/account.svg'),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
