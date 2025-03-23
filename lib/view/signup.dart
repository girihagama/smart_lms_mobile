import 'package:flutter/material.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String _errorMessage = '';

  void _signup() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = '';
      });
  
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

              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white54),
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
            const   SizedBox(height: 20),
               TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Re-enter Password',
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
                  style:const TextStyle(color: Colors.red),
                ),
            const  SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  minimumSize:const  Size(double.infinity, 40),
                ),
                child: const Text('Signup'),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}