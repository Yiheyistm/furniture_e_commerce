// ignore_for_file: prefer_final_fields

import 'package:furniture_e_commerce/core/features/main/cart/models/product.dart';

class ShoppinmgCart {
  List<Product> _items = [];

  void addItem(Product product) {
    _items.add(product);
  }

  void removeItem(Product product) {
    _items.remove(product);
  }

  double calculateTotal() {
    return _items.fold(0, (total, product) => total + product.price);
  }

  List<Product> get items => _items;
}
