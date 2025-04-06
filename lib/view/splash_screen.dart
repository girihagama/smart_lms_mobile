import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_lms/controller/apiclient.dart';
import 'package:smart_lms/model/common.dart';
import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/landing_screen.dart';
import 'package:smart_lms/view/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {




  Future<String?> getBearerToken() async {
    final pref = await SharedPreferences.getInstance();
    ApiClient.bearerToken= pref.getString('bearerToken') ?? "";
    Common.email = pref.getString('email') ?? "";
  print(ApiClient.bearerToken);
    return pref.getString('bearerToken');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBaseUrl();

  }
   getBaseUrl() async {
    try {
      final FirebaseRemoteConfig _remoteConfig =
          await FirebaseRemoteConfig.instance;
      final baseUrl = await _remoteConfig.getString('REMOTE_CONFIG');

      final Map<String, dynamic> configMap = jsonDecode(baseUrl);

      Common.baseUrl = configMap['api_base_url'];
      ApiClient.baseURL= Common.baseUrl;

      // print(baseUrl);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBearerToken(),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            );
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return LandingScreen();
          }
        });
  }
}
