import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 176, 157),
          elevation: 0,
          title: Text(
            'My Orders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _ordersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.yellow.shade900),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/grocery.svg',
                            fit: BoxFit.cover,
                            width: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document['pickupTime'],
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/iftar.svg',
                            fit: BoxFit.cover,
                            width: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document['productName'],
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: document['accepted'] == true
                              ? Icon(Icons.run_circle_sharp)
                              : Icon(Icons.access_time)),
                      title: document['accepted'] == true
                          ? Text(
                              'Accepted',
                              style: TextStyle(color: Colors.yellow.shade900),
                            )
                          : Text(
                              'Not Accepted',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                      trailing: Text(
                        'Amount' +
                            ' ' +
                            document['productPrice'].toStringAsFixed(2),
                        style: TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                      subtitle: Text(
                        formatedDate(
                          document['orderDate'].toDate(),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Order Details',
                        style: TextStyle(
                          color: Colors.yellow.shade900,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text('View Order Details'),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.network(
                              document['productImage'][0],
                            ),
                          ),
                          title: Text(document['productName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(''),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ('Vendor :'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ' + document['pickupTime'].toString(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ('Quantity :'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ' + document['quantity'].toString(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ('Payment Method :'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ' + document['paymentMethod'].toString(),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    ('Pickup Time :'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '  ' +
                                          document['bussinessName'].toString(),
                                    ),
                                  ),
                                ],
                              ),
                              document['accepted'] == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Schedule Delivery Date'),
                                        Text(formatedDate(
                                            document['scheduleDate'].toDate()))
                                      ],
                                    )
                                  : Text(''),
                              ListTile(
                                title: Text(
                                  'Buyer Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(document['fullName']),
                                        ),
                                        Text(document['lastName']),
                                      ],
                                    ),
                                    Text(document['email']),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              }).toList(),
            );
          },
        ));
  }
}
