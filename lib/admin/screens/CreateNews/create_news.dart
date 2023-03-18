import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/services/firestore_service.dart';
import 'package:flutter/material.dart';

class CreateNews extends StatefulWidget {
  const CreateNews({
    Key? key,
    this.newModel,
  }) : super(key: key);

  final NewModel? newModel;

  @override
  State<CreateNews> createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    if (widget.newModel != null) {
      titleController.text = widget.newModel!.title;
      descriptionController.text = widget.newModel!.description;
      imageController.text = widget.newModel!.image;
      urlController.text = widget.newModel!.url;
    }
  }

  Future<void> create() async {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty || imageController.text.isEmpty || urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen tüm alanları doldurunuz.'),
        ),
      );
      return;
    }
    if (widget.newModel != null) {
      NewModel newModel = NewModel(
        title: titleController.text,
        description: descriptionController.text,
        image: imageController.text,
        url: urlController.text,
        id: widget.newModel!.id,
      );
      await FirestoreService().updateNews(newModel);
      Navigator.pop(context);
    } else {
      NewModel newModel = NewModel(
        title: titleController.text,
        description: descriptionController.text,
        image: imageController.text,
        url: urlController.text,
        id: DateTime.now().millisecondsSinceEpoch,
      );
      await FirestoreService().createNews(newModel);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haber Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Başlık',
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: 'Açıklama',
              ),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(
                labelText: 'Resim',
              ),
            ),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'URL',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              child: ElevatedButton(
                onPressed: create,
                child: Text('Oluştur'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
