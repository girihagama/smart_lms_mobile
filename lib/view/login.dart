import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/common.dart';
import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBaseUrl();
  }

  void _login({required String email, required String password}) async {
    final bodyParam = {
      "email": "mathusanmathu24@gmail.com",
      "password": "abcd"
    };

    EasyLoading.showProgress(0,status: 'Please wait..');

    final response = await ApiClient.call('token', ApiMethod.POST,
        authorized: false, data: bodyParam);
        EasyLoading.dismiss();

        if(response?.data !=null && response?.statusCode ==200 ){

          ApiClient.bearerToken = response?.data['token'];
          await EasyLoading.showSuccess('Login Successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return HomePage();
          }));

        }else{
          EasyLoading.showError('Something went wrong try again later');
        }

    // await http.post(Uri.parse('${Common.baseUrl}/token'),
    // body: bodyParam
    // );
    print(response);
  }


  Future<String>resetPassword({required String email}) async {

    final response = await ApiClient.call('forget/$email', ApiMethod.POST,
    
    authorized: false
    );
    if(response?.data !=null  && response?.statusCode ==200){
        return response?.data['message'];

    }else {
      return 'Something went wrong try again later';
    }




  }

  getBaseUrl() async {
    try {
      final FirebaseRemoteConfig _remoteConfig =
          await FirebaseRemoteConfig.instance;
      final baseUrl = await _remoteConfig.getValue('REMOTE_CONFIG');
      print(baseUrl);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text('Login Page'),
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
                children: [
                  Text(
                    'Login',
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
              Spacer(
                flex: 1,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Checkbox(value: true, onChanged: (e) {}),
                  // Text('REMEMBER ME', style: TextStyle(color: Colors.white),),
                  // SizedBox(
                  //   width: 30,
                  // ),
                  GestureDetector(
                    onTap: ()async {

                        if(_emailameController.text.isNotEmpty){
                          final res =await resetPassword(email: _emailameController.text.trim());
                          await  EasyLoading.showSuccess('Password Reset Plz Activate the account',duration:const Duration(seconds: 5));
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SignupPage();
                          }));

                        }else{
                          EasyLoading.showError('Enter Your Email!');
                        }

                    },
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignupPage();
                      }));
                    },
                    child: Text(
                      'ACTIVATE ACCOUNT',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue),
                    ),
                  ),
                ],
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _login(
                      email: _emailameController.text.trim(),
                      password: _passwordController.text.trim());
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return HomePage();
                  // }));
                },
                child: Container(
                  height: 50,
                  width: 300,
                  child: Center(
                      child: Text(
                    'SIGN IN',
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
              const SizedBox(height: 10),
              Text(
                'CONTACT FOR REGISTER',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.mail,
                        color: Colors.white,
                      )),
                ],
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                'I AGREE WITH THE SMART LIBRARY PRIVACY POLICY',
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
