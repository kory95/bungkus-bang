import 'package:bungkus_bang/views/screens/main_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import 'inner_screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final TextEditingController _cash = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 56, 176, 157),
        elevation: 0,
        title: Text(
          'Cart'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];

                return Card(
                  child: SizedBox(
                    height: 220,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl[0]),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cartData.productName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  '\RM${cartData.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    color:
                                        const Color.fromARGB(255, 56, 176, 157),
                                  ),
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        cartData.paymentMethod,
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        cartData.bussinessName,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    OutlinedButton(
                                      onPressed: null,
                                      child: Text(
                                        cartData.pickupTime,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 56, 176, 157)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: cartData.quantity == 1
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .decreaMent(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.minus,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            cartData.quantity.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: cartData
                                                        .productQuantity ==
                                                    cartData.quantity
                                                ? null
                                                : () {
                                                    _cartProvider
                                                        .increament(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider.removeItem(
                                          cartData.productId,
                                        );
                                      },
                                      icon: Icon(
                                        CupertinoIcons.cart_badge_minus,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOUR CART IS EMPTY!'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 56, 176, 157),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'CONTINUE SHOPPING'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: _cartProvider.totalPrice == 0.00
          ? null
          : Container(
              height: 80,
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: \RM${_cartProvider.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CheckoutScreen(
                          name: _cash.text,
                        );
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 56, 176, 157),
                      //onPrimary: Colors.black,
                    ),
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
