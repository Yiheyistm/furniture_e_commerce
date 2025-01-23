import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/features/main/cart/cart.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/home/screeen/home.dart';
import 'package:furniture_e_commerce/core/features/main/itemUpload/screen/item_upload_screen.dart';
import 'package:furniture_e_commerce/core/features/main/profile/screen/profile.dart';
import 'package:furniture_e_commerce/core/features/main/search/search.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _activeIndex = 0;

  void onItemTaped(int i) {
    setState(() {
      _activeIndex = i;
    });
    Logger().i(_activeIndex);
  }

  // screens list
  final List<Widget> _screens = [
    const Home(),
    const Search(),
    const UploadView(),
    const Cart(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MyAuthProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final userModel = authProvider.userModel;
    return Scaffold(
      body: _screens.elementAt(_activeIndex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Theme.of(context).shadowColor,
        buttonBackgroundColor: _activeIndex != 4
            ? Theme.of(context).primaryColor
            : Colors.transparent,
        height: 60,
        items: [
          const Icon(Icons.home_rounded, size: 20),
          const Icon(Icons.search_rounded, size: 20),
          const Icon(Icons.add, size: 20),
          Badge.count(
              count: cartProvider.cartItems.length,
              backgroundColor: AppColors.infoColor,
              child: const Icon(Icons.shopping_cart, size: 20)),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(userModel.img),
            onBackgroundImageError: (_, __) {
              setState(() {
                userModel.img = AppAssets.profileUrl;
              });
            },
          ),
        ],
        onTap: (index) {
          setState(() {
            _activeIndex = index;
          });
        },
      ),
    );
  }
}
