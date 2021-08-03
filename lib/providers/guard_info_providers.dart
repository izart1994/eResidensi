import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/guard_model.dart';

class GuardInfoProviders with ChangeNotifier {
  List<GuardModel> _guardData = [];

  final String authToken;

  GuardInfoProviders(this.authToken, this._guardData);

  List<GuardModel> get guardData {
    return _guardData;
  }

  GuardModel findGuardId(String id) {
    return _guardData.firstWhere((guardData) => guardData.guardId == id);
  }

  Future<void> fetchGuardData() async {
    var url =
        'https://flutter.otaiwebsite.com/api/show_guard_data.php?id=$authToken';

    final response = await http.get(url);
    print(response);
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<GuardModel> loadedData = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (authData) {
        loadedData.add(
          GuardModel(
            guardId: authData['guard_id'],
            guardName: authData['guard_name'],
            guardNokp: authData['guard_nokp'],
            guardUsername: authData['guard_username'],
            guardPassword: authData['guard_password'],
          ),
        );
        _guardData = loadedData;
        notifyListeners();
      },
    );
  }

  Future<void> updateGuardData(
      String authId, String nameGuard, String nokpGuard, String usernameGuard) async {
    final Map<String, dynamic> authData2 = {
      'authid': authId,
      'nameguard': nameGuard,
      'nokpguard': nokpGuard,
      'username': usernameGuard,
    };
    print(authData2);

    try {
      final response2 = await http.post(
        'https://flutter.otaiwebsite.com/api/edit_guard_data.php?id=$authId&name=$nameGuard&nokp=$nokpGuard&username=$usernameGuard',
        body: json.encode(authData2),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData2 = json.decode(response2.body);
      print(responseData2);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
