import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Info',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Image.asset(
        //     ImageService.icon('menu'),
        //     height: 20,
        //   ),
        // ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                      'Altın fiyatları uygulamamız üzerinden anlık olarak güncellenen gram, çeyrek, ons, reşat, cumhuriyet, tam altın gibi ürünlerin alış ve satış fiyatlarına ulaşabilir ve 24 saat içerisindeki değişim bilgilerini görüntüleyebilirsiniz.'),
                ),
              ),

              Card(
                child: ListTile(
                  onTap: () {
                    Share.share('https://play.google.com/store/apps/details?id=com.altinfiyatlari.tr');
                  },
                  leading: Icon(Icons.share),
                  title: Text('Uygulamayı Paylaş'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    inAppReview.requestReview();
                  },
                  leading: Icon(Icons.rate_review),
                  title: Text('Puan Ver ve Yorum Yap'),
                ),
              ),
              // Card(
              //   child: ListTile(
              //     leading: Icon(Icons.mail),
              //     title: Text('İletişim'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
