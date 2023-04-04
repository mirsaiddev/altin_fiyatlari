import 'package:altin_fiyatlari/screens/BottomNavBar/bottom_nav_bar.dart';
import 'package:altin_fiyatlari/utils/google_ads/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
    _loadInterstitialAd();
  }

  AppOpenAd? openAd;

  Future<void> _loadInterstitialAd() async {
    try {
      await AppOpenAd.load(
        adUnitId: AdHelper.splashAdUnitId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {},
            );
            openAd = ad;
            print('AD LOADED');
          },
          onAdFailedToLoad: (err) {
            print('InterstitialAd failed to load: $err');
          },
        ),
        orientation: AppOpenAd.orientationPortrait,
      );
    } catch (e) {
      print('InterstitialAd failed to load2: $e');
    }
  }

  showAd() {
    openAd?.show();
  }

  void navigate() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        try {
          showAd();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reklam yüklenemedi'),
            ),
          );
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/icons/logo.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Altın Fiyatları',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
