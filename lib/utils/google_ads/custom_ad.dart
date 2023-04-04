import 'package:altin_fiyatlari/utils/google_ads/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// <><><><><> ================ BANNER AD ================ <><><><><> ///

class BannerAdClass extends StatefulWidget {
  const BannerAdClass({Key? key}) : super(key: key);

  @override
  State<BannerAdClass> createState() => _BannerAdClassState();
}

class _BannerAdClassState extends State<BannerAdClass> {
  BannerAd? _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _loadBanner();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: SizedBox(
            width: double.infinity,
            height: _bannerAd != null
                ? _bannerAd?.size.height.toDouble() ?? 50
                : 50,
            child: _bannerAd != null ? AdWidget(ad: _bannerAd!) : SizedBox(),
          ),
        ),
      ),
    );
  }

  _loadBanner() async {
    await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ['F0BBA98E732040A976BF910824BE0730']));
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // _bannerAd = ad as BannerAd;
          _isBannerAdReady = true;
          setState(() {});
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _bannerAd!.load();
  }
}
