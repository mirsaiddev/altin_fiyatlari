import 'package:altin_fiyatlari/admin/screens/Currencies/currency_detail.dart';
import 'package:altin_fiyatlari/utils/constants.dart';
import 'package:flutter/material.dart';

class AdminCurrencies extends StatefulWidget {
  const AdminCurrencies({Key? key}) : super(key: key);

  @override
  State<AdminCurrencies> createState() => _AdminCurrenciesState();
}

class _AdminCurrenciesState extends State<AdminCurrencies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currencies'),
      ),
      body: ListView.builder(
        itemCount: allCurrencies.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(allCurrencies[index]['ShortName']),
              subtitle: Text(allCurrencies[index]['code']),
              trailing: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CurrencyDetail(currency: allCurrencies[index]);
                  }));
                },
                child: Text('Yazıya Git'),
              ),
            ),
          );
        },
      ),
    );
  }
}
