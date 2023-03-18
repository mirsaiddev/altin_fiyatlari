import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<NewModel>> getNews() async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore.collection('news').doc('news').get();
    Map data = documentSnapshot.data() as Map;
    return data.values.map((e) => NewModel.fromMap(e)).toList();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getStreamNews() {
    return firebaseFirestore.collection('news').doc('news').snapshots();
  }
}
