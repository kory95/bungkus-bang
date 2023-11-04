import 'package:bungkus_bang/views/screens/productDetail/widget/store_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorsStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _vendorsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade900,
            ),
          );
        }

        return Container(
          height: 400,
          child: ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                final storeData = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StoreDetailScreen(
                        storeData: storeData,
                      );
                    }));
                  },
                  child: ListTile(
                    title: Text(storeData['bussinessName']),
                    subtitle: Text(storeData['countryValue']),
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 56, 176, 157),
                      backgroundImage: NetworkImage(storeData['storeImage']),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
