import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/items.dart';
import 'package:furniture_e_commerce/core/features/main/profile/model/order.dart'
    as MyOrder;

class CartProvider extends ChangeNotifier {
  List<Items> _cartItems = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> ensureCartDocumentExists() async {
    final doc = _firestore.collection('cart').doc('currentCart');
    final docSnapshot = await doc.get();
    if (!docSnapshot.exists) {
      await doc.set({
        'items': [],
        'totalAmount': 0.0,
        'date': DateTime.now().toIso8601String(),
      });
    }
  }

  Future initializeCache() async {
    QuerySnapshot snapshot = await _firestore.collection('cart').get();
    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<Items> firebaseItems =
          (data['items'] as List).map((item) => Items.fromJson(item)).toList();
      _cartItems.addAll(firebaseItems);
    }
    notifyListeners();
  }

  List<Items> get cartItems => _cartItems;

  void addToCart(Items item) {
    int index =
        _cartItems.indexWhere((element) => element.itemID == item.itemID);
    if (index != -1) {
      _cartItems[index].quantity += 1;
      _updateItemInFirebase(_cartItems[index]);
    } else {
      item.quantity = 1;
      _cartItems.add(item);
      _addItemToFirebase(item);
    }
    notifyListeners();
  }

  void removeFromCart(Items item) {
    _cartItems.removeWhere((element) => element.itemID == item.itemID);
    _removeItemFromFirebase(item);
    notifyListeners();
  }

  void increaseItem(String id) {
    int index = _cartItems.indexWhere((element) => element.itemID == id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
      _updateItemInFirebase(_cartItems[index]);
      notifyListeners();
    }
  }

  void decreaseItem(String id) {
    int index = _cartItems.indexWhere((element) => element.itemID == id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
        _updateItemInFirebase(_cartItems[index]);
      } else {
        _removeItemFromFirebase(_cartItems[index]);
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double calculateProductPrice() {
    double productPrice = 0;
    for (Items item in _cartItems) {
      productPrice += double.parse(item.itemPrice ?? '0') * item.quantity;
    }
    return productPrice;
  }

  double getProductPrice() {
    return calculateProductPrice();
  }

  double getDiscount() {
    double discountRate = 15 / 100;
    return discountRate * getProductPrice();
  }

  double getTax() {
    double taxRate = 5 / 100;
    return taxRate * getProductPrice();
  }

  double calculateTotalPrice() {
    double productPrice = calculateProductPrice();
    double discount = getDiscount();
    double tax = getTax();
    return productPrice - discount + tax;
  }

  Future<void> placeOrder(MyOrder.Order order) async {
    await _firestore.collection('orders').doc(order.id).set(order.toMap());
  }

  Future<void> _updateItemInFirebase(Items item) async {
    _removeItemFromFirebase(item);
    await _firestore.collection('cart').doc('currentCart').update({
      'items': FieldValue.arrayUnion([item.toMap()]),
      'totalAmount': calculateTotalPrice(),
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _addItemToFirebase(Items item) async {
    await _firestore.collection('cart').doc('currentCart').update({
      'items': FieldValue.arrayUnion([item.toMap()]),
      'totalAmount': calculateTotalPrice(),
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _removeItemFromFirebase(Items item) async {
    await _firestore.collection('cart').doc('currentCart').update({
      'items': FieldValue.arrayRemove([item.toMap()]),
      'totalAmount': calculateTotalPrice(),
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> clearCart() async {
    _cartItems = [];
    await _firestore.collection('cart').doc('currentCart').update({
      'items': [],
      'totalAmount': 0.0,
      'date': DateTime.now().toIso8601String(),
    });
    notifyListeners();
  }

  Future<List<Items>> getItemsByCategory(String category, itemID) async {
    QuerySnapshot snapshot = await _firestore
        .collection('items')
        .where('category', isEqualTo: category)
        .where('itemID', isNotEqualTo: itemID)
        .limit(4)
        .get();

    List<Items> items = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      if (data['publishedDate'] is Timestamp) {
        data['publishedDate'] =
            (data['publishedDate'] as Timestamp).toDate().toIso8601String();
      }
      return Items.fromJson(data);
    }).toList();
    print(items);
    return items;
  }
}
