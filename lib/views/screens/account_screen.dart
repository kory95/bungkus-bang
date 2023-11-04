import 'package:bungkus_bang/views/screens/cart_screen.dart';
import 'package:bungkus_bang/views/screens/inner_screens/edit_profile.dart';
import 'package:bungkus_bang/views/screens/inner_screens/order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'auth/login_screen.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Malay', 'locale': Locale('my', 'MALAY')},
    {'name': 'বাংলাদেশ', 'locale': Locale('bengali', 'BANGLA')},
    {'name': 'नेपाल', 'locale': Locale('ne', 'NEPAL')},
    {'name': 'اردو', 'locale': Locale('urdu', 'PAKISTAN')},
  ];

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose a Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            print(locale[index]['name']);
                            updatelanguage(locale[index]['locale']);
                          },
                          child: Text(locale[index]['name'])),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return _auth.currentUser == null
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: const Color.fromARGB(255, 56, 176, 157),
              title: Text(
                'Profile',
                style: TextStyle(letterSpacing: 4),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.star),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: const Color.fromARGB(255, 56, 176, 157),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Login Account TO Access Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 176, 157),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'LOGIN ACCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ],
            ),
          )
        : FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 2,
                    backgroundColor: const Color.fromARGB(255, 56, 176, 157),
                    title: Text(
                      'Profile',
                      style: TextStyle(letterSpacing: 4),
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                const Color.fromARGB(255, 56, 176, 157),
                            backgroundImage: NetworkImage(data['userImage']),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                data['firstName'],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              data['lastName'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['email'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditProfileScreen(
                                userData: data,
                              );
                            }));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 56, 176, 157),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                                child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            builddialog(context);
                          },
                          leading: SvgPicture.asset(
                            'assets/icons/language-translator-icon.svg',
                            fit: BoxFit.cover,
                            width: 25,
                          ),
                          title: Text('Language'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CartScreen();
                            }));
                          },
                          leading: SvgPicture.asset(
                            'assets/icons/shopping-bag-icon.svg',
                            fit: BoxFit.cover,
                            width: 20,
                          ),
                          title: Text('Cart'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CustomerOrderScreen();
                            }));
                          },
                          leading: SvgPicture.asset(
                            'assets/icons/pending-order-icon.svg',
                            fit: BoxFit.cover,
                            width: 20,
                          ),
                          title: Text('Order'),
                        ),
                        ListTile(
                          onTap: () async {
                            await _auth.signOut().whenComplete(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            });
                          },
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          );
  }
}
