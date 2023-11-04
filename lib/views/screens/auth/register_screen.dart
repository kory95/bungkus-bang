import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/auth_controller.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  Uint8List? _image;
  bool _isLoading = false;

  late String firstName;

  late String lastName;

  late String phoneNumber;

  late String email;

  late String password;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  registerUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authController.createUser(
      firstName,
      lastName,
      phoneNumber,
      email,
      password,
      _image,
    );
    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Get.to(LoginScreen());
      Get.snackbar(
        'Success',
        'Congratulations Account has been Created For You',
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
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Register to BungkusBang'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 68,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 56, 176, 157),
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                        child: _image != null
                            ? Image.memory(_image!)
                            : IconButton(
                                onPressed: () {
                                  selectGalleryImage();
                                },
                                icon: SvgPicture.asset(
                                  'assets/icons/image-upload-icon.svg',
                                  fit: BoxFit.cover,
                                  width: 40,
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onChanged: (value) {
                            firstName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please First Name Must not be Empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'First Name'.tr,
                            labelStyle: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          onChanged: (value) {
                            lastName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Last Name Must Not Be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Last Name'.tr,
                            labelStyle: TextStyle(
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 1,
                      ),
                      Flexible(
                        child: TextFormField(
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Phone Number Must Not Be empty';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(
                              Icons.phone_android,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
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
                      labelText: 'Create Password'.tr,
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
                          registerUser();
                        } else {
                          Get.snackbar('Form Not Valid'.tr,
                              'Please Fill In The Fields'.tr,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: EdgeInsets.all(15),
                              colorText: Colors.white,
                              backgroundColor: Colors.red);
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'REGISTER'.tr,
                              style: TextStyle(
                                color: Color.fromARGB(255, 56, 176, 157),
                              ),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text(
                      'Login',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
