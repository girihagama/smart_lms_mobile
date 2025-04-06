import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_lms/service/notification_service.dart';
import 'package:smart_lms/view/home.dart';
import 'package:smart_lms/view/landing_screen.dart';
import 'package:smart_lms/view/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_lms/view/splash_screen.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
      await NotificationService().init();
      setupRemoteConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Smart LMS',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
Future<void> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 5),
  ));

  await remoteConfig.fetchAndActivate();
}
