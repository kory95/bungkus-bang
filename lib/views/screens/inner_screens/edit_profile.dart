import 'package:bungkus_bang/views/screens/main_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? address;

  @override
  void initState() {
    setState(() {
      _firstNameController.text = widget.userData['firstName'];
      _lastNameController.text = widget.userData['lastName'];
      _phoneNumberController.text = widget.userData['phoneNumber'];
      _emailController.text = widget.userData['email'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 3,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter First Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Last Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(13.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'UPDATING');
            await _firestore
                .collection('buyers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'firstName': _firstNameController.text,
              'lastName': _lastNameController.text,
              'phoneNumber': _phoneNumberController.text,
              'email': _emailController.text,
            }).whenComplete(() {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MainScreen();
            }));
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 56, 176, 157),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              'UPDATE',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, letterSpacing: 6),
            )),
          ),
        ),
      ),
    );
  }
}
