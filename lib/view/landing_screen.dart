import 'package:smart_lms/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'V1.0',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/book.svg',
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  'WELCOME TO',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'SMART LIBRARY MOBILE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    child: Center(child: Text('SIGN IN', style: TextStyle(fontSize: 18,color: Colors.white),)),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.blue,
                      Colors.green,
                    ])),
                  ),
                )
                ),
          ],
        ),
      ),
    );
  }
}
