import 'dart:convert';

import 'package:app/model/channels/connect_channel_model.dart';
import 'package:app/model/error_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChannelServices {
  static final String? host = dotenv.env['URL'];

  static Future<Object> connect({required String uid}) async {
    Uri url = Uri.parse('$host/connect/$uid');

    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        return ConnectChannelModel.fromJson(json.decode(res.body));
      }

      return ErrorModel(
          statusCode: res.statusCode, message: 'Something went wrong');
    } catch (e) {
      return ErrorModel(statusCode: 100, message: e.toString());
    }
  }
}
