import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/model/dio_response.dart';
import 'package:altin_fiyatlari/services/dio_service.dart';

class DataService {
  Future<List<CurrenyModel>> getCurrencies(List currencies) async {
    String url = 'economy/getCurrencyPersonal?code=${currencies.join(',')}';
    print('url: $url');
    DioResponse dioResponse = await DioService().request(url);
    return dioResponse.data['data'].map<CurrenyModel>((e) => CurrenyModel.fromMap(e)).toList();
  }
}
