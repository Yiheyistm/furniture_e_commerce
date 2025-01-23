import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/home/components/virtual_ar_view_screen.dart';
import 'package:furniture_e_commerce/core/features/main/productDetail/widgets/related_item_type.dart';
import 'package:furniture_e_commerce/core/features/main/productDetail/widgets/upper_selection.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatefulWidget {
  final Items item;
  const ProductDetails({super.key, required this.item});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  _ProductDetailsState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          UpperSection(itemsInfo: widget.item),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.2,
            child: ProductDetailsSection(itemsInfo: widget.item),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  RelatedItemsSection(
                      category: widget.item.category!,
                      itemID: widget.item.itemID!),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "View in your room",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => VirtualARViewScreen(
                                    clickedItemImageLink:
                                        widget.item.itemBgRemoveUrl,
                                  )));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class ProductDetailsSection extends StatelessWidget {
  final Items? itemsInfo;
  final BuildContext? context;

  const ProductDetailsSection({
    super.key,
    this.itemsInfo,
    this.context,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(29, 34, 29, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                itemsInfo?.itemName ?? "default name",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Price: ${itemsInfo?.itemPrice ?? "0"} Br",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor.withOpacity(.7),
                ),
              ),
              // Rating Section
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    "4.5", // Replace with the actual rating value
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                  CustomText(
                    "  (50 reviews)", // Replace with the actual rating value
                    fontSize: 15,
                    color: Color.fromARGB(255, 218, 210, 210),
                  ),
                ],
              ),
              // const COunterSection(),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text("${itemsInfo?.itemDescription}",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}
