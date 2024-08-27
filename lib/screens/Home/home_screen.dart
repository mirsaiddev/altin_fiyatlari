import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/NewDetail/new_detail_screen.dart';
import 'package:altin_fiyatlari/services/firestore_service.dart';
import 'package:altin_fiyatlari/services/image_service.dart';
import 'package:altin_fiyatlari/utils/google_ads/custom_ad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    List<CurrenyModel> currencies = dataProvider.currencies;
    print('currencies.length: ${currencies.length}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Güncel altın fiyatları',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirestoreService().getStreamNews(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          List<NewModel> news = [];
                          Map data = snapshot.data!.data() as Map;
                          for (Map<String, dynamic> item in data.values) {
                            news.add(NewModel.fromMap(item));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(width: 24),
                                for (NewModel newModel in news) NewCard(newModel: newModel),
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: 40),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currencies.length,
                      itemBuilder: (context, index) {
                        CurrenyModel currency = currencies[index];
                        return DataCard(
                          currency: currency,
                        );
                      },
                    ),
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

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.currency,
  }) : super(key: key);

  final CurrenyModel currency;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageService.icon('gold-2'),
                      height: 30,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currency.FullName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Builder(
                  builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Alış: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green)),
                              Text('${currency.buying} TL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.green)),
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Satış: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                              Text('${currency.selling} TL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red)),
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Degişim: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
                              Text('%${currency.changeRate.toStringAsFixed(3)}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                ImageService.icon('poligon'),
                                height: 40,
                              ),
                              Text(
                                dataProvider.tick.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({
    Key? key,
    required this.newModel,
  }) : super(key: key);

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewDetailScreen(newModel: newModel)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 170,
                    width: 270,
                    child: Image.network(
                      newModel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  newModel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
