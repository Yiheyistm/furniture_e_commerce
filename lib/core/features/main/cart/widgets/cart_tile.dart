import 'package:flutter/material.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CartTile extends StatelessWidget {
  final Items item;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartTile({
    super.key,
    required this.item,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).canvasColor,
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item.itemImage ?? ''),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    item.itemName ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Product Price
                  Text(
                    'Birr ${item.itemPrice ?? "0"}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Product Description
                  Text(
                    item.sellerName ?? '',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  // Product Description
                  Text(
                    item.status ?? '',
                    style: const TextStyle(fontSize: 10, color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const SizedBox(width: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove_circle,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: onDecrease,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text('${item.quantity}')),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: const Icon(Icons.add_circle,
                        color: AppColors.blueColor),
                    onPressed: onIncrease,
                  ),
                ),
              ],
            ),
            // Remove Button

            // Positioned(
            //   right: -15,
            //   top: -10,
            //   child: IconButton(
            //     icon: const Icon(Icons.dangerous, color: Colors.red),
            //     onPressed: onRemove,
            //   ),
            // ),
            const SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: const Icon(Icons.phone),
                    color: Colors.blue,
                    onPressed: () => _showConfirmationDialog(
                        context,
                        'Make a Call',
                        'Do you want to make a call to ${item.sellerName}?',
                        () {
                      launchUrlString(
                          'tel:${item.sellerPhone ?? '1234567890'}');
                     
                    }),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: IconButton(
                    icon: const Icon(Icons.message),
                    color: Colors.green,
                    onPressed: () => _showConfirmationDialog(
                      context,
                      'Send Message',
                      'Do you want to send a message to ${item.sellerName}?',
                      () {
                        launchUrlString(
                            'sms:${item.sellerPhone ?? '1234567890'}');
                      },
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

  Future<void> _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomText(
                'Cancel',
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
              child: const CustomText(
                'Confirm',
                color: AppColors.snackBarGreen,
              ),
            ),
          ],
        );
      },
    );
  }
}
