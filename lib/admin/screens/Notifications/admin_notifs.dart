import 'package:altin_fiyatlari/admin/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key}) : super(key: key);

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> send(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String token = '/topics/all';

    await NotificationService().sendNotificationAll(token: token, title: titleController.text, body: contentController.text);

    titleController.clear();
    contentController.clear();

    // snackbar Bildirim gönderildi

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirim Oluştur'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          padding: const EdgeInsets.all(50),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bildirim Oluştur',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen başlığı giriniz';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Bildirim Başlığı',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: contentController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen içeriği giriniz';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Bildirim İçeriği',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        onTap: () {
                          send(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 55,
                          width: 300,
                          child: Center(
                            child: Text(
                              'Gönder',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
