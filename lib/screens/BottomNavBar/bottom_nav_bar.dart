import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/Home/home_screen.dart';
import 'package:altin_fiyatlari/screens/News/news_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  List pages = [
    HomeScreen(),
    NewsScreen(),
    Container(
      color: Colors.blue,
    ),
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);

    dataProvider.getCurrencies();
    dataProvider.getNews();
    FirebaseMessaging.instance.subscribeToTopic('all');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Altın Fiyatları',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Altın ve Ekonomi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
