import 'package:altin_fiyatlari/admin/screens/Currencies/admin_currencies.dart';
import 'package:altin_fiyatlari/admin/screens/News/admin_news.dart';
import 'package:altin_fiyatlari/admin/screens/Notifications/admin_notifs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/data_provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Widget currentPage = AdminNews();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    dataProvider.getCurrencies();
    dataProvider.getNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            elevation: 1,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Admin Paneli',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                Card(
                  color: currentPage is AdminNews
                      ? Colors.grey[200]
                      : Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.newspaper),
                    title: Text('Haberler'),
                    onTap: () {
                      setState(() {
                        currentPage = AdminNews();
                      });
                    },
                  ),
                ),
                Card(
                  color: currentPage is AdminNotifications
                      ? Colors.grey[200]
                      : Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Bildirimler'),
                    onTap: () {
                      setState(() {
                        currentPage = AdminNotifications();
                      });
                    },
                  ),
                ),
                Card(
                  color: currentPage is AdminCurrencies
                      ? Colors.grey[200]
                      : Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.monetization_on),
                    title: Text('Currencies'),
                    onTap: () {
                      setState(() {
                        currentPage = AdminCurrencies();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: currentPage,
          ),
        ],
      ),
    );
  }
}
