import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/screens/Home/home_screen.dart';
import 'package:altin_fiyatlari/utils/google_ads/ad_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CurrenctDetailUser extends StatefulWidget {
  const CurrenctDetailUser({Key? key, required this.currency})
      : super(key: key);

  final CurrenyModel currency;

  @override
  State<CurrenctDetailUser> createState() => _CurrenctDetailUserState();
}

class _CurrenctDetailUserState extends State<CurrenctDetailUser> {
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
    interstitialAd!.show();
  }

  String? content;
  Future<void> getCurrencyContent() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('curencies')
            .doc('curencies')
            .get();
    Map data = documentSnapshot.data() as Map;
    print('data: $data');
    content = data[widget.currency.code] ?? '';

    // change every $price text to $widget.currency.buying

    content = content?.replaceAll(
        '\$selling', '${widget.currency.selling.toStringAsFixed(2)}');
    content = content?.replaceAll(
        '\$buying', '${widget.currency.buying.toStringAsFixed(2)}');
    print('content: $content');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadInterstitialAd();

      getCurrencyContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.currency.FullName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Image.asset(
        //     ImageService.icon('menu'),
        //     height: 20,
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DataCard(
              currency: widget.currency,
              showDetails: false,
            ),
            Expanded(child: HtmlWidget(content ?? '')),
          ],
        ),
      ),
    );
  }
}
