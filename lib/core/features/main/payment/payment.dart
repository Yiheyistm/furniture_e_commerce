import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chapasdk/chapasdk.dart';
import 'package:furniture_e_commerce/core/global/config.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';

class PaymentMethod {
  static const String mpesa = 'mpesa';
  static const String cbebirr = 'cbebirr';
  static const String telebirr = 'telebirr';
  static const String ebirr = 'ebirr';
  final Config config = locator<Config>();

  Future<Chapa> paymentInitiate(BuildContext context, double amount) async {
    var r = Random();
    var args;
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String transactionRef =
        List.generate(10, (index) => chars[r.nextInt(chars.length)]).join();

    Chapa message = Chapa.paymentParameters(
      context: context, // context
      publicKey: config.chapa_api_key,
      currency: 'ETB',
      amount: amount.toString(),
      email: FirebaseAuth.instance.currentUser!.email!,
      phone: '0923895809',
      firstName: await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) => value.data()!['userName'])
          .catchError((e) => 'No First Name'),
      lastName: 'No Last Name',
      txRef: transactionRef,
      title: 'Online Payment',
      desc: 'Online Order Payment',
      nativeCheckout: true,
      namedRouteFallBack: RouteName.cartView,
      showPaymentMethodsOnGridView: false,
      availablePaymentMethods: [
        mpesa,
        cbebirr,
        telebirr,
        ebirr,
      ],
    );

        Future.delayed(Duration.zero, () {
    
        if (ModalRoute.of(context)?.settings.arguments != null) {
          args = ModalRoute.of(context)?.settings.arguments;
          print('message after payment');
          print(args['message']);
          print(args['transactionReference']);
          print(args['paidAmount']);
        }
      });
  
    return message;
  }
}
