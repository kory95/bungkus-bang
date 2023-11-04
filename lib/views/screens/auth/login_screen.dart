import 'package:bungkus_bang/views/screens/auth/register_screen.dart';
import 'package:bungkus_bang/views/screens/main_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../vendor/views/auth/vendor_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  bool _isLoading = false;

  late String email;

  late String password;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.loginUser(email, password);
    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.offAll(MainScreen());
      Get.snackbar(
        'Success',
        'Logged In',
        colorText: Colors.white,
        backgroundColor: const Color.fromARGB(255, 56, 176, 157),
        margin: EdgeInsets.all(15),
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      Get.snackbar(
        'Error Ocurred',
        res.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(15),
        icon: Icon(
          Icons.message,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: const Color.fromARGB(255, 56, 176, 157),
                      child: Image.asset(
                        'assets/icons/LOGO-BUNGKUSBANG-TRANSPARENT.png',
                        width: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                        onPressed: () {
                          builddialog(context);
                        },
                        child: Text('Change Language')),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email Adress Must Not Be empty'.tr;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Adress'.tr,
                      labelStyle: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Password Must Not Be empty'.tr;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Password'.tr,
                      labelStyle: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginUser();
                        } else {
                          Get.snackbar('Error Validating Fields'.tr,
                              'Fields Cannot Be Empty'.tr);
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.cyan,
                            )
                          : Text(
                              'LOGIN'.tr,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 56, 176, 157),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have a customer account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return RegisterScreen();
                          })));
                        },
                        child: Text(
                          'Register here',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Need a vendor account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return VendorAuthScreen();
                          })));
                        },
                        child: Text(
                          'Log in vendor account',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
