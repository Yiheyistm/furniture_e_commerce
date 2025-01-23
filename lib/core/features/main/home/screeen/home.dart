// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/home/components/carousel_slider.dart';
import 'package:furniture_e_commerce/core/features/main/home/components/filter_chips.dart';
import 'package:furniture_e_commerce/core/features/main/home/components/product_grid.dart';
import 'package:furniture_e_commerce/core/features/main/home/sideDrawer/side_drawer.dart';
import 'package:furniture_e_commerce/core/features/main/search/search.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void updateSelectedCategories(List<String> categories) {
    setState(() {
      selectedCategories = categories;
    });
  }

  List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // final userModel = myAuthProvider.userModel;
    Logger().i("UserModel: $selectedCategories");
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _scaffoldKey.currentState?.openDrawer(),
                      child: SvgPicture.asset(
                        AppAssets.menuIcon,
                        width: 15,
                        height: 15,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Search()));
                      },
                      child: SvgPicture.asset(
                        AppAssets.searchIcon,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "Furniture",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                // CAROUSEL SLIDER
                const FurnitureCarousel(),
                const SizedBox(
                  height: 15,
                ),
                // CATEGORIES
                SelectedCategories(
                  onCategoriesSelected: updateSelectedCategories,
                ),

                const SizedBox(
                  height: 16,
                ),
                // PRODUCT GRID
                ProductGrid(
                  selectdCategories: selectedCategories,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
