import 'package:altin_fiyatlari/admin/screens/Home/admin_home.dart';
import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:altin_fiyatlari/screens/Home/home_screen.dart';
import 'package:altin_fiyatlari/screens/Splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDyu3YNtWyw4mQpmEk9nejmKZL35QOXso4",
        authDomain: "altin-fiyatlari-12b81.firebaseapp.com",
        projectId: "altin-fiyatlari-12b81",
        storageBucket: "altin-fiyatlari-12b81.appspot.com",
        messagingSenderId: "542215248957",
        appId: "1:542215248957:web:20316711d9037fa6421e54",
        measurementId: "G-ZVY899S1WR",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
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
          fontFamily: 'Sk-Modernist',
        ),
        debugShowCheckedModeBanner: false,
        home: kIsWeb ? AdminHome() : SplashScreen(),
      ),
    );
  }
}
