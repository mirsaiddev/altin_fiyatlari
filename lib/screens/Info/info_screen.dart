import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

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
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Gizlilik Politikası'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Uygulamayı Paylaş'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text('Puan Ver ve Yorum Yap'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('İletişim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
