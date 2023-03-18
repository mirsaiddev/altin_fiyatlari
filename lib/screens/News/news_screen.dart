import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/provider/data_provider.dart';
import 'package:altin_fiyatlari/screens/NewDetail/new_detail_screen.dart';
import 'package:altin_fiyatlari/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    List<NewModel> news = dataProvider.news;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Altın ve Ekonomi',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              ImageService.icon('menu'),
              height: 20,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return NewTile(
                newModel: news[index],
              );
            },
          ),
        ));
  }
}

class NewTile extends StatelessWidget {
  const NewTile({
    Key? key,
    required this.newModel,
  }) : super(key: key);

  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewDetailScreen(
              newModel: newModel,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 90,
                width: 90,
                child: Image.network(newModel.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newModel.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  // Text(newModel.site, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey)),
                  // SizedBox(height: 8),
                  // Row(
                  //   children: [
                  //     // Image.asset('lib/assets/icons/Heart.png', height: 16, width: 16),
                  //     // SizedBox(width: 4),
                  //     // Text('6', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                  //     // SizedBox(width: 16),
                  //     // Image.asset('lib/assets/icons/Chat.png', height: 16, width: 16),
                  //     // SizedBox(width: 4),
                  //     // Text('2', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: MyColors.grey1)),
                  //     // SizedBox(width: 16),
                  //     Text(newModel.date, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
