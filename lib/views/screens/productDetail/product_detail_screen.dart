import 'package:bungkus_bang/provider/cart_provider.dart';
import 'package:bungkus_bang/views/screens/main_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutDateFormat = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormat.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;
  String? _paymentMethod;
  String? _pickUpTime;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                      imageProvider: NetworkImage(
                          widget.productData['imageUrl'][_imageIndex])),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData['imageUrl'].length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _imageIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.yellow.shade900,
                                  )),
                                  height: 60,
                                  width: 60,
                                  child: Image.network(
                                      widget.productData['imageUrl'][index]),
                                ),
                              ),
                            );
                          }),
                    ))
              ],
            ),
            SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                'RM' +
                    ' ' +
                    widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            ExpansionTile(
              title: Text(
                'Pickup Time',
              ),
              children: [
                Container(
                  height: 48,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['pickupTime'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: _pickUpTime ==
                                    widget.productData['pickupTime'][index]
                                ? Colors.yellow
                                : null,
                            child: ButtonTheme(
                              child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _pickUpTime = widget
                                          .productData['pickupTime'][index];
                                    });
                                    print(_pickUpTime);
                                  },
                                  child: Text(
                                    widget.productData['pickupTime'][index],
                                  )),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            ExpansionTile(
              title: Text(
                'Payment Method',
              ),
              children: [
                Container(
                  height: 45,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['paymentMethod'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: _paymentMethod ==
                                    widget.productData['paymentMethod'][index]
                                ? Colors.yellow
                                : null,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _paymentMethod = widget
                                        .productData['paymentMethod'][index];
                                  });
                                  print(_paymentMethod);
                                },
                                child: Text(
                                  widget.productData['paymentMethod'][index],
                                )),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () async {
                  if (_paymentMethod == null) {
                    Get.snackbar('Please Select a Payment Method', '');
                  } else {
                    _cartProvider.addProductToCart(
                      widget.productData['productName'],
                      widget.productData['productId'],
                      widget.productData['imageUrl'],
                      1,
                      widget.productData['quantity'],
                      widget.productData['productPrice'],
                      widget.productData['vendorId'],
                      widget.productData['bussinessName'],
                      _paymentMethod!,
                      _pickUpTime!,
                    );

                    Get.snackbar(
                        'You have added  ${widget.productData['productName']} to the cart',
                        '');

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
                  }
                },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.grey
                  : const Color.fromARGB(255, 56, 176, 157),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _cartProvider.getCartItem
                            .containsKey(widget.productData['productId'])
                        ? Text(
                            'DALAM BAKUL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          )
                        : Text(
                            'TAMBAH KE DALAM BAKUL',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
