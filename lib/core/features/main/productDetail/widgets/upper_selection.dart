import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/helper/show_notification.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpperSection extends StatelessWidget {
  final Items? itemsInfo;

  const UpperSection({super.key, this.itemsInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(itemsInfo?.itemImage ??
              AppAssets.dummyImage), 
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonBackButton(),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).canvasColor,
                          elevation: 0,
                          title: const Text("Add to Cart"),
                          content: const Text(
                            "Do you want to keep shopping or go to the cart?",
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.addToCart(itemsInfo!);
                                showNotification('Item added to cart', context,
                                    AppColors.snackBarGreen);
                              },
                              child: const Text(
                                "Keep Shopping",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.addToCart(itemsInfo!);
                                context.pushNamed(RouteName.cartView);
                                showNotification('Item added to cart', context,
                                    AppColors.snackBarGreen);
                              },
                              child: const Text(
                                "Go to Cart",
                                style:
                                    TextStyle(color: AppColors.snackBarGreen),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon:  Icon(Icons.add_shopping_cart_rounded, size: 30, color: Theme.of(context).primaryColor,)),
            ],
          ),
        ),
      ),
    );
  }
}
