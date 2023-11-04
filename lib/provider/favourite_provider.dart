import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../models/favorite_models.dart';

class FavouriteProvider with ChangeNotifier {
  Map<String, WishListModels> _cartItems = {};

  Map<String, WishListModels> get getwishItem {
    return _cartItems;
  }

  void addProductToWish(
      String productName,
      String productId,
      List imageUrl,
      int quantity,
      int productQuantity,
      double price,
      String vendorId,
      String paymentMethod,
      String pickupTime,
      Timestamp scheduleDate) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCart) => WishListModels(
                productName: exitingCart.productName,
                productId: exitingCart.productId,
                imageUrl: exitingCart.imageUrl,
                quantity: exitingCart.quantity,
                productQuantity: exitingCart.productQuantity,
                price: exitingCart.price,
                vendorId: exitingCart.vendorId,
                paymentMethod: exitingCart.paymentMethod,
                scheduleDate: exitingCart.scheduleDate,
                pickupTime: exitingCart.pickupTime,
              ));

      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => WishListModels(
              productName: productName,
              productId: productId,
              imageUrl: imageUrl,
              quantity: quantity,
              productQuantity: productQuantity,
              price: price,
              vendorId: vendorId,
              paymentMethod: paymentMethod,
              scheduleDate: scheduleDate,
              pickupTime: pickupTime));

      notifyListeners();
    }
  }

  removeItem(productId) {
    _cartItems.remove(productId);

    notifyListeners();
  }

  removeAllItem() {
    _cartItems.clear();

    notifyListeners();
  }
}
