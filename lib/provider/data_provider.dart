import 'dart:async';

import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/model/news_model.dart';
import 'package:altin_fiyatlari/services/data_service.dart';
import 'package:altin_fiyatlari/services/firestore_service.dart';
import 'package:altin_fiyatlari/utils/constants.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<CurrenyModel> currencies = [];
  List<NewModel> news = [];
  Timer? timer;

  Future<void> getCurrencies() async {
    List currencyCodes = allCurrencies.map((e) => e['code']).toList();
    List<CurrenyModel> _currencies = await DataService().getCurrencies();
    print('_currencies: $_currencies');
    currencies = _currencies;
    notifyListeners();
  }

  Future<void> getNews() async {
    news = await FirestoreService().getNews();
    news.sort((a, b) => b.id.compareTo(a.id));
    notifyListeners();
  }

  int? tick = 0;

  void starTimer() {
    // get data every one minute
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      tick = 60 - timer.tick % 60;
      notifyListeners();
      if (timer.tick % 60 == 0) {
        getCurrencies();
      }
    });
  }
}
