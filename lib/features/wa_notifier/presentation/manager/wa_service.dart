import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/constants.dart';

class WAService {
  static Future<void> sendWhatsAppTemp(
    BuildContext context, {
    required String phone,
    required String temp,
  }) async {
    var url =
        Uri.parse('https://graph.facebook.com/v17.0/148621851676411/messages');
    try {
      final body = jsonEncode({
        "messaging_product": "whatsapp",
        "recipient_type": "individual",
        "to": "91$phone",
        "type": "template",
        "template": {
          "name": temp,
          "language": {"code": "en"},
        }
      });
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Constants.waToken}',
      };
      final http.Response response =
          await http.post(url, body: body, headers: headers);
      if (response.statusCode == 200) {
        print("Sent Successfully !! ${response.body}");
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Message Sent SuccessFully",
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
