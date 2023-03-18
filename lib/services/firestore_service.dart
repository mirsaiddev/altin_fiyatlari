import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<NewModel>> getNews() async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore.collection('news').doc('news').get();
    Map data = documentSnapshot.data() as Map;
    return data.values.map((e) => NewModel.fromMap(e)).toList();
  }

  Future<void> createNews(NewModel newModel) async {
    await firebaseFirestore.collection('news').doc('news').set(
      {newModel.id.toString(): newModel.toMap()},
      SetOptions(merge: true),
    );
  }

  Future<void> deleteNews(NewModel newModel) async {
    await firebaseFirestore.collection('news').doc('news').update({newModel.id.toString(): FieldValue.delete()});
  }

  Future<void> updateNews(NewModel newModel) async {
    await firebaseFirestore.collection('news').doc('news').update({newModel.id.toString(): newModel.toMap()});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamNews() {
    return firebaseFirestore.collection('news').doc('news').snapshots();
  }
}
