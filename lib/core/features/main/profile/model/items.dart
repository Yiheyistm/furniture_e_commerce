// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? itemID;
  String? itemName;
  String? itemDescription;
  String? itemImage;
  String? itemBgRemoveUrl;
  String? sellerName;
  String? sellerPhone;
  String? category;
  String? itemPrice;
  Timestamp? publishedDate;
  String? status;
  int quantity;

  Items(
      {this.itemID,
      this.itemName,
      this.itemDescription,
      this.itemImage,
      this.itemBgRemoveUrl,
      this.itemPrice,
      this.publishedDate,
      this.sellerName,
      this.sellerPhone,
      this.status,
      this.category,
      this.quantity = 1});

  Items.fromJson(Map<String, dynamic> json) : quantity = json["quantity"] ?? 1 {
    print(json["publishedDate"].runtimeType);
    itemID = json["itemID"];
    itemName = json["itemName"];
    itemDescription = json["itemDescription"];
    itemImage = json["itemImage"];
    itemBgRemoveUrl = json["itemBgRemoveUrl"];
    sellerName = json["sellerName"];
    sellerPhone = json["sellerPhone"];
    itemPrice = json["itemPrice"];
    publishedDate = json["publishedDate"] != null
        ? Timestamp.fromDate(DateTime.parse(json["publishedDate"]))
        : null;
    status = json["status"];
    category = json["category"];
  }

  // to map

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemImage': itemImage,
      'itemBgRemoveUrl': itemBgRemoveUrl,
      'sellerName': sellerName,
      'sellerPhone': sellerPhone,
      'itemPrice': itemPrice,
      'publishedDate': publishedDate?.toDate().toIso8601String(),
      'status': status,
      'quantity': quantity,
      'category': category
    };
  }
}
