import 'package:altin_fiyatlari/admin/screens/Home/admin_home.dart';
import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:altin_fiyatlari/screens/Home/home_screen.dart';
import 'package:altin_fiyatlari/screens/Splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAfVK-KqotBBEVJ78HKKOs9QMzqDJ__vdE",
          authDomain: "altin-fiyatlari-559a8.firebaseapp.com",
          projectId: "altin-fiyatlari-559a8",
          storageBucket: "altin-fiyatlari-559a8.appspot.com",
          messagingSenderId: "966075675098",
          appId: "1:966075675098:web:dcbe542591d68c5d6210e3",
          measurementId: "G-B1R434FK26"),
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseMessaging.instance.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MaterialApp(
        title: '',
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Sk-Modernist',
        ),
        debugShowCheckedModeBanner: false,
        home: kIsWeb ? AdminHome() : SplashScreen(),
      ),
    );
  }
}
