import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/home/components/discount_tag.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:go_router/go_router.dart';

class ProductTile extends StatelessWidget {
  final Items itemsInfo;
  final BuildContext? context;

  const ProductTile({
    super.key,
    required this.itemsInfo,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteName.productDetailView, extra: itemsInfo);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  itemsInfo.itemImage ??
                      'https://example.com/default_image.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                      child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              itemsInfo.itemName ?? "DEFAULT",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CustomText(
                            'Birr: ${itemsInfo.itemPrice ?? "NAN"} BR',
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      CustomText(
                        itemsInfo.sellerName ?? "NO NAME",
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            itemsInfo.status ?? "UNKNOWN",
                            fontSize: 10,
                            color: const Color.fromARGB(255, 85, 168, 53),
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(width: 26),
                          const DiscountTag(value: '15%'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
