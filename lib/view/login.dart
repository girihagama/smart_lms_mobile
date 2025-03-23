import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _errorMessage = '';

  void _login() {
    //Validate User

    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignupPage();
      }));
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
    } else {
      setState(() {
        _errorMessage = 'Please enter both username and password';
      });
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
                controller: _usernameController,
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
                  Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SignupPage();
                      }));
                    },
                    child: Text(
                      'SIGNUP',
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
                  _login();
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
