import 'package:flutter/widgets.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  getFormData({
    String? productName,
    double? productPrice,
    int? quantity,
    String? category,
    DateTime? scheduleDate,
    List<String>? imageUrlList,
    String? brandName,
    List<String>? paymentMethod,
    List<String>? pickupTime,
    String? bussinessName,
  }) {
    if (productName != null) {
      productData['productName'] = productName;
    }

    if (productPrice != null) {
      productData['productPrice'] = productPrice;
    }

    if (quantity != null) {
      productData['quantity'] = quantity;
    }

    if (category != null) {
      productData['category'] = category;
    }

    if (pickupTime != null) {
      productData['pickupTime'] = pickupTime;
    }

    if (scheduleDate != null) {
      productData['scheduleDate'] = scheduleDate;
    }
    if (imageUrlList != null) {
      productData['imageUrlList'] = imageUrlList;
    }

    if (brandName != null) {
      productData['brandName'] = brandName;
    }
    if (paymentMethod != null) {
      productData['paymentMethod'] = paymentMethod;
    }
    if (paymentMethod != null) {
      productData['bussinessName'] = bussinessName;
    }

    notifyListeners();
  }

  clearData() {
    productData.clear();
    notifyListeners();
  }
}
