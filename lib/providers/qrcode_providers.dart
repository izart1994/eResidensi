import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/qrcode_model.dart';

class QrCodeProviders with ChangeNotifier {
  List<QRCode> _qrInfo = [];
  var responses = [];
  String _id;
  String _detail;

  final String authToken;

  QrCodeProviders(this.authToken, this._qrInfo);

  List<QRCode> get qrInfo {
    return _qrInfo;
  }

  String get id {
    return _id;
  }

  String get detail {
    return _detail;
  }

  Future<void> qrauthenticate(
      String detail, String latitude, String longitude) async {
    final Map<String, dynamic> authData = {
      'detail': detail,
      'latitude': latitude,
      'longitude': longitude,
    };
    print(authData);

    try {
      final response = await http.post(
        'https://flutter.otaiwebsite.com/api/qrcode.php?id=$authToken&detail=$detail&latitude=$latitude&longitude=$longitude',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      print(responseData);

      _id = responseData['id'];
      _detail = responseData['detail'];

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
