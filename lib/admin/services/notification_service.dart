import 'dart:convert';

import 'package:http/http.dart' as http;

String key =
    'AAAAfj6MHD0:APA91bF8YorndJRG3OluUkcV3AdogWvSmki-FNC1KMnyDvLEezMpcQKj8HPQCKyFX5Wv5TH1JvdcN9mg7zEju4y6Mo_pJwIdAT8qzXJ5H0HX9Om_3YCMpGtCvazzHiXLE4-Z25dSUHOo';

class NotificationService {
  Future<void> sendNotification({
    required String recieverToken,
    required String title,
    required String body,
    required String senderName,
    required String senderProfilePictureUrl,
  }) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$key',
    };

    Map requestBody = {
      "to": recieverToken,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
      },
      "data": {
        "title": title,
        "body": body,
        "senderName": senderName,
        "senderProfilePictureUrl": senderProfilePictureUrl,
      }
    };

    await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('notif sent to ${recieverToken}');
  }

  Future<void> sendAdminNotification({
    required String recieverToken,
    required String title,
    required String body,
  }) async {
    String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$key',
    };

    Map requestBody = {
      "to": recieverToken,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
      },
      "data": {
        "type": "admin",
      }
    };

    await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('notif sent to ${recieverToken}');
  }

  Future<void> sendMessageNotification({
    required String recieverToken,
    required String title,
    required String body,
    required String senderName,
    required String? senderProfilePictureUrl,
    required String chatId,
    required String type,
  }) async {
    String url = 'https://fcm.googleapis.com/fcm/send';

    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$key',
    };

    print('gelen title $title');
    print('gelen senderName $senderName');

    String messageBody = body;
    if (body.contains('.com')) {
      messageBody = 'Medya';
    }

    Map requestBody = {
      "to": recieverToken,
      "notification": {
        "title": senderName,
        "body": messageBody,
        "mutable_content": true,
      },
      "data": {
        "type": type,
        "title": senderName,
        "body": messageBody,
        "senderName": senderName,
        "senderProfilePictureUrl": senderProfilePictureUrl,
        "chatID": chatId,
      }
    };

    await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    print('notif sent to ${recieverToken}');
  }

  Future<void> sendNotificationAll({
    required String token,
    required String title,
    required String body,
  }) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String>? headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$key',
    };

    Map requestBody = {
      "to": token,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
      },
      "data": {
        "title": title,
        "body": body,
      }
    };

    await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(requestBody),
    );
  }
}
