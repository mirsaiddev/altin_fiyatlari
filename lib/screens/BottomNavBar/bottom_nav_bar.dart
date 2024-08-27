import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/Home/home_screen.dart';
import 'package:altin_fiyatlari/screens/Info/info_screen.dart';
import 'package:altin_fiyatlari/screens/News/news_screen.dart';
import 'package:altin_fiyatlari/utils/google_ads/ad_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    NewsScreen(),
    InfoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    getData();
    _loadInterstitialAd();
  }

  void getData() {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);

    dataProvider.getCurrencies();
    dataProvider.getNews();
    FirebaseMessaging.instance.subscribeToTopic('all');
    setState(() {});
  }

  InterstitialAd? interstitialAd;

  Future<void> _loadInterstitialAd() async {
    try {
      await InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {},
            );
            interstitialAd = ad;
            print('AD LOADED');
            showAd();
          },
          onAdFailedToLoad: (err) {
            print('InterstitialAd failed to load: $err');
          },
        ),
      );
    } catch (e) {
      print('InterstitialAd failed to load2: $e');
    }
  }

  showAd() {
    if (interstitialAd != null) interstitialAd!.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      screens: pages,
      popAllScreensOnTapAnyTabs: true,
      navBarStyle: NavBarStyle.style6,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      onItemSelected: (value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        currentIndex = value;
        if (currentIndex != 2) {
          showAd();
          _loadInterstitialAd();
        }
        setState(() {});
      },
      items: [
        PersistentBottomNavBarItem(
          activeColorPrimary: Colors.amber[800]!,
          textStyle: TextStyle(fontSize: 12),
          icon: Icon(Icons.home),
          title: ('Altın Fiyatları'),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: Colors.amber[800]!,
          textStyle: TextStyle(fontSize: 12),
          icon: Icon(Icons.newspaper),
          title: ('Altın ve Ekonomi'),
        ),
        PersistentBottomNavBarItem(
          activeColorPrimary: Colors.amber[800]!,
          textStyle: TextStyle(fontSize: 12),
          icon: Icon(Icons.info),
          title: ('Info'),
        ),
      ],
    )

        //  pages[currentIndex], bottomNavigationBar:

        //  BottomNavigationBar(
        //   selectedFontSize: 12,
        //   unselectedFontSize: 12,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Altın Fiyatları',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.newspaper),
        //       label: 'Altın ve Ekonomi',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.info),
        //       label: 'Info',
        //     ),
        //   ],
        //   currentIndex: currentIndex,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: (index) {
        //     currentIndex = index;
        //     showAd();
        //     _loadInterstitialAd();

        //     setState(() {});
        //   },
        // ),
        );
  }
}
