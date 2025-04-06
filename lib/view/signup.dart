import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _errorMessage = '';

  void _signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });

      print('Username: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    } else {
      setState(() {
        _errorMessage = 'Please enter both username and password';
      });
    }
  }

  Future<bool> activateAccount(
      {required String password,
      required String email,
      required String otp}) async {
    final bodyParam = {"password": password};
    try {
      final response = await ApiClient.call(
          'verify/$email/$otp', ApiMethod.POST,
          data: bodyParam);

      if (response?.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response?.data);

        if (responseData["action"] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text('Signup Page'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activate',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Smart Library',
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  )
                ], 
              ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Your all in-one Library Solution',
                      style: TextStyle(color: Colors.white),
                    )),
                    Spacer(),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white54),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
                maxLength: 6,
                controller: _otpController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter the otp',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (mounted) {
                      final res = await activateAccount(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          otp: _otpController.text.trim());
                      if (res == true) {
                        await EasyLoading.showSuccess('User Activated');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      } else {
                        EasyLoading.showError('Something went wrong');
                      }
                    }
                  } else {
                    EasyLoading.showError('Invalid Details');
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  child: Center(
                      child: Text(
                    'ACTIVATE',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Colors.green,
                      ])),
                ),
              ),
              Spacer(),
                            Spacer()

            ],
          ),
        ),
      ),
    );
  }
}
