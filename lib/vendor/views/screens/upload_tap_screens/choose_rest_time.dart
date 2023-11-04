import 'package:bungkus_bang/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupTimeScreen extends StatefulWidget {
  @override
  State<PickupTimeScreen> createState() => _PickupTimeScreenState();
}

class _PickupTimeScreenState extends State<PickupTimeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;
  final TextEditingController _pickupController = TextEditingController();

  bool _entered = false;

  List<String> _pickupTime = [
    '6:00 AM-\n8:00 AM',
    '1:00 PM-\n2:00 PM',
    '5:30 PM-\n7:30 PM'
  ];

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
                          _pickupTime.add(_pickupController.text);
                          _pickupController.clear();
                        });
                        print(_pickupTime);
                      },
                      child: Text(
                        'Add',
                      ),
                    )
                  : Text(''),
            ],
          ),
          if (_pickupTime.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 63,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _pickupTime.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _pickupTime.removeAt(index);
                              _productProvider.getFormData(
                                  pickupTime: _pickupTime);
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
                                _pickupTime[index],
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
          if (_pickupTime.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(pickupTime: _pickupTime);
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
