import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:intl/intl.dart';

class VendorOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
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
                return Slidable(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                document['fullName'],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              document['lastName'],
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 14,
                              child: document['accepted'] == true
                                  ? Icon(Icons.delivery_dining)
                                  : Icon(Icons.access_time)),
                          title: document['accepted'] == true
                              ? Text(
                                  'Accepted',
                                  style:
                                      TextStyle(color: Colors.yellow.shade900),
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
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  document['productName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          ('Quantity :'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        document['quantity'].toString(),
                                      ),
                                    ],
                                  ),
                                  document['accepted'] == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                    ),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await _firestore
                                .collection('orders')
                                .doc(document['orderId'])
                                .update({
                              'accepted': false,
                            });
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Reject',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            await _firestore
                                .collection('orders')
                                .doc(document['orderId'])
                                .update({
                              'accepted': true,
                            });
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Accept',
                        ),
                      ],
                    ));
              }).toList(),
            );
          },
        ));
  }
}
