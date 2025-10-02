// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/features/main/cart/provider/cartProvider.dart';
import 'package:furniture_e_commerce/core/features/main/cart/widgets/cart_amount.dart';
import 'package:furniture_e_commerce/core/features/main/payment/payment.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/order.dart';
import 'package:furniture_e_commerce/core/helper/alert_helper.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

class BottomRaw extends StatelessWidget {
  final CartProvider cartProvider;

  const BottomRaw({
    super.key,
    required this.cartProvider,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartProvider.calculateTotalPrice();
    double discount = cartProvider.getDiscount();
    double tax = cartProvider.getTax();

    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 18,
          ),
          // Use the calculated total price
          CartAmmountRaw(
            name: "Product Price",
            ammount:
                "Birr. ${cartProvider.calculateProductPrice().toStringAsFixed(2)}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use hypothetical discount
          CartAmmountRaw(
            name: "Discount",
            ammount: "Birr. ${discount.toStringAsFixed(2)}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use hypothetical tax
          CartAmmountRaw(
            name: "Tax",
            ammount: "Birr. ${tax.toStringAsFixed(2)}",
          ),
          const SizedBox(
            height: 8,
          ),
          // Use the calculated total price, discount, and tax for the total amount
          CartAmmountRaw(
            name: "Total Price",
            ammount:
                "Birr. ${cartProvider.calculateTotalPrice().toStringAsFixed(2)}",
            isTotal: true,
          ),
          const Spacer(),
          CustomButton(
            text: "Place Order",
            onTap: () {
              // Show invoice dialog
              _showInvoiceDialog(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _showInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildInvoiceDialogContent(context),
        );
      },
    );
  }

  Widget _buildInvoiceDialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor, // Set the background color here
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Invoice header with app name, credentials, dummy QR, etc.
            Row(
              children: [
                CircleAvatar(
                  child: Image.asset('assets/icons/logo.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'RoomifyAR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Build your dream space with us.',
              style: TextStyle(),
            ),
            const SizedBox(height: 26),

            // Table of ordered items with their details
            _buildOrderedItemsTable(),

            // Calculated total price, discount, tax, and related information
            const SizedBox(height: 16),
            Text(
              'Total Price: Birr. ${cartProvider.calculateTotalPrice().toStringAsFixed(3)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                'Discount: Birr. ${cartProvider.getDiscount().toStringAsFixed(3)}'),
            Text('Tax: Birr. ${cartProvider.getTax().toStringAsFixed(3)}'),
            const SizedBox(height: 16),

            // Close button or any other actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    if (cartProvider.cartItems.isNotEmpty) {
                      final message = await PaymentMethod().paymentInitiate(
                          context, cartProvider.calculateTotalPrice());
                      if (message == 'success') {
                        final order = Order(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          date: DateTime.now(),
                          totalAmount: cartProvider.calculateTotalPrice(),
                          items: cartProvider.cartItems,
                        );
                        cartProvider.placeOrder(order);
                        cartProvider.clearCart();
                        Navigator.pop(context);

                        AlertHelpers.showAlert(
                          context,
                          'Order placed successfully!',
                          type: DialogType.success,
                        );
                      } else {
                        AlertHelpers.showAlert(
                          context,
                          'Payment failed!',
                        );
                      }
                    }
                    // Close the dialog
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: AppColors.snackBarGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Close the dialog
                  },
                  child: const Text(
                    'Discard',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderedItemsTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          children: [
            _buildTableCell('ID'),
            _buildTableCell('Qty'),
            _buildTableCell('Product'),
            _buildTableCell('Price'),
          ],
        ),
        for (var item in cartProvider.cartItems)
          TableRow(
            children: [
              _buildTableCell(item.itemID.toString()),
              _buildTableCell(item.quantity.toString()),
              _buildTableCell(item.itemName.toString()),
              _buildTableCell('Birr. ${item.itemPrice.toString()}'),
            ],
          ),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
