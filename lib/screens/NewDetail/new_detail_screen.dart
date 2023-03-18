// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:altin_fiyatlari/utils/google_ads/ad_helper.dart';
import 'package:altin_fiyatlari/utils/google_ads/custom_ad.dart';
import 'package:flutter/material.dart';

import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewDetailScreen extends StatefulWidget {
  const NewDetailScreen({
    Key? key,
    required this.newModel,
  }) : super(key: key);

  final NewModel newModel;

  @override
  State<NewDetailScreen> createState() => _NewDetailScreenState();
}

class _NewDetailScreenState extends State<NewDetailScreen> {
  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
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
              onAdDismissedFullScreenContent: (ad) {
                _loadInterstitialAd();
              },
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
    interstitialAd!.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      widget.newModel.title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       backgroundColor: Colors.grey,
                    //       radius: 14,
                    //     ),
                    //     SizedBox(width: 8),
                    //     Text('CNN Haber', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
                    //     SizedBox(width: 8),
                    //     CircleAvatar(radius: 2, backgroundColor: Colors.grey),
                    //     SizedBox(width: 8),
                    //     Text('Kas 28, 2022', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
                    //   ],
                    // ),
                    // SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          widget.newModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      widget.newModel.description,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            BannerAdClass(),
          ],
        ),
      ),
    );
  }
}
