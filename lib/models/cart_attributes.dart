import 'package:flutter/widgets.dart';

class CartAttr with ChangeNotifier {
  final String productName;

  final String productId;

  final List imageUrl;

  int quantity;

  int productQuantity;

  double price;

  final String vendorId;

  final String paymentMethod;

  final String pickupTime;
  final String bussinessName;

  CartAttr({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.productQuantity,
    required this.price,
    required this.vendorId,
    required this.paymentMethod,
    required this.pickupTime,
    required this.bussinessName,
  });

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }
}
