import 'package:altin_fiyatlari/admin/screens/CreateNews/create_news.dart';
import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNews extends StatefulWidget {
  const AdminNews({Key? key}) : super(key: key);

  @override
  State<AdminNews> createState() => _AdminNewsState();
}

class _AdminNewsState extends State<AdminNews> {
  @override
  Widget build(BuildContext context) {
    int itemCount = MediaQuery.of(context).size.width ~/ 300;
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNews()));
            },
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Yeni Haber', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: itemCount),
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(news[index].image, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              news[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Düzenle'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Sil'),
                              ),
                            ],
                            onSelected: (val) async {
                              if (val == 'delete') {
                                await FirestoreService().deleteNews(news[index]);
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNews(newModel: news[index])));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: news.length,
          );
        },
      ),
    );
  }
}
