import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/guard_patrol_model.dart';

class GuardPatrolProviders with ChangeNotifier {
  List<GuardPatrolModel> _items = [];

  final String authToken;

  GuardPatrolProviders(this.authToken, this._items);

  List<GuardPatrolModel> get items {
    return _items;
  }

  Future<void> fetchPatrol() async {
    var url = 'https://flutter.otaiwebsite.com/api/guard_control.php?auth=$authToken';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<GuardPatrolModel> loadedData = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (controlData) {
        loadedData.add(
          GuardPatrolModel(
            controlId: controlData['control_id'],
            controlSession: controlData['control_session'],
            controlDate: controlData['control_date'],
            controlStartTime: controlData['control_start_time'],
            controlEndTime: controlData['control_end_time'],
          ),
        );

        _items = loadedData;
        notifyListeners();
      },
    );
  }
}
