import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';

class Order {
  final String id;
  final List<Items> items;
  final double totalAmount;
  final DateTime date;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'date': date.toIso8601String(),
    };
  }
}
