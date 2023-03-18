import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/services/data_service.dart';
import 'package:altin_fiyatlari/services/firestore_service.dart';
import 'package:altin_fiyatlari/utils/constants.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<CurrenyModel> currencies = [];
  List<NewModel> news = [];

  Future<void> getCurrencies() async {
    List currencyCodes = allCurrencies.map((e) => e['code']).toList();
    List<CurrenyModel> _currencies = await DataService().getCurrencies(currencyCodes);
    currencies = _currencies;
    notifyListeners();
  }

  Future<void> getNews() async {
    news = await FirestoreService().getNews();
    notifyListeners();
  }
}
