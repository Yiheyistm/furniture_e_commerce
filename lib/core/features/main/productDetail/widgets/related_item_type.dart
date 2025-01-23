import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/productDetail/product_details.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class RelatedItemsSection extends StatelessWidget {
  final String category;
  final String itemID;
  
  const RelatedItemsSection({super.key, required this.category, required this.itemID});

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<CartProvider>(context);
    return FutureBuilder<List<Items>>(
      future: itemsProvider.getItemsByCategory(category, itemID),
      builder: (context, snapshot) {
        Logger().i("Related Items: ${snapshot.data}");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          Logger().e("Error loading related items: ${snapshot.error}");
          return const Center(child: Text('Error loading related items'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No related items found'));
        } else {
          final relatedItems = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  "Related Items",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: relatedItems.length,
                    itemBuilder: (context, index) {
                      final item = relatedItems[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(item: item),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item.itemImage!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: CustomText(
                                item.itemName!,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
