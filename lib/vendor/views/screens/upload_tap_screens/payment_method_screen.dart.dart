import 'package:bungkus_bang/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;
  final TextEditingController _sizeController = TextEditingController();

  bool _entered = false;

  List<String> _paymentMethod = ['Pay at counter'];

  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  width: 100,
                ),
              ),
              _entered == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          56,
                          176,
                          157,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _paymentMethod.add(_sizeController.text);
                          _sizeController.clear();
                        });
                        print(_paymentMethod);
                      },
                      child: Text(
                        'Add',
                      ),
                    )
                  : Text(''),
            ],
          ),
          if (_paymentMethod.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _paymentMethod.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _paymentMethod.removeAt(index);
                              _productProvider.getFormData(
                                  paymentMethod: _paymentMethod);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 56, 176, 157),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _paymentMethod[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          if (_paymentMethod.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(paymentMethod: _paymentMethod);
                setState(() {
                  _isSave = true;
                });
              },
              child: Text(
                _isSave ? 'Saved' : 'save',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
