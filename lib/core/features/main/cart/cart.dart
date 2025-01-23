import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/cart/widgets/bottom_raw.dart';
import 'package:furniture_e_commerce/core/features/main/cart/widgets/cart_tile.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  void fetchCartItems() async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);
  await cartProvider.initializeCache();
  setState(() {});
}
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
  
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonBackButton(),
                    CustomText(
                      "Your Cart",
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    Icon(
                      Icons.abc,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (ctx, i) {
                  final item = cart.cartItems[i];

                  return CartTile(
                    item: item,
                    quantity: item.quantity,
                    onIncrease: () {
                      // Increase the quantity of the item
                      cart.increaseItem(item.itemID!);
                    },
                    onDecrease: () {
                      // Decrease the quantity of the item
                      cart.decreaseItem(item.itemID!);
                    },
                    onRemove: () {
                      // Remove the item from the cart
                      cart.removeFromCart(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomRaw(cartProvider: cart),
    );
  }
}


