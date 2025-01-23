// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:furniture_e_commerce/core/features/main/home/components/product_tile.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

class ProductGrid extends StatelessWidget {
  List<String?> selectdCategories;
  ProductGrid({
    super.key,
    required this.selectdCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: selectdCategories.isNotEmpty
            ? FirebaseFirestore.instance
                .collection("items")
                .where("category", whereIn: selectdCategories)
                .orderBy("publishedDate", descending: true)
                .snapshots()
            : FirebaseFirestore.instance
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var products = snapshot.data!;

            if (products.docs.isEmpty) {
              return const Center(
                child: Text("No Products Found"),
              );
            }

            return FadeInLeft(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 30,
                ),
                itemCount: products.docs.length,
                itemBuilder: (context, index) {
                  var productData =
                      products.docs[index].data() as Map<String, dynamic>;
                  productData['publishedDate'] =
                      (productData['publishedDate'] as Timestamp)
                          .toDate()
                          .toString();
                  Items eachItemInfo = Items.fromJson(productData);
                  return ProductTile(
                    itemsInfo: eachItemInfo,
                    context: context,
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            // Use a custom loading indicator
            return const Center(
              child: SpinKitSpinningLines(
                color: AppColors.primaryColor,
                lineWidth: 4,
                size: 70.0, // Choose your desired size
              ),
            );
          }
        },
      ),
    );
  }
}
