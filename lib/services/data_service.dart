import 'package:altin_fiyatlari/model/currency_model.dart';
import 'package:altin_fiyatlari/model/dio_response.dart';
import 'package:altin_fiyatlari/services/dio_service.dart';

class DataService {
  Future<List<CurrenyModel>> getCurrencies() async {
    DioResponse dioResponse = await DioService().request('index.php?return=1');
    print('dioResponse: ${dioResponse.data}');
    return dioResponse.data['data']
        .map<CurrenyModel>((e) => CurrenyModel.fromMap(e))
        .toList();
  }
}
