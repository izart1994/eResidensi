import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/guard_schedule_model.dart';

class GuardScheduleProviders with ChangeNotifier {
  List<GuardScheduleModel> _schedule = [];

  final String authToken;

  GuardScheduleProviders(this.authToken, this._schedule);

  List<GuardScheduleModel> get schedule {
    return _schedule;
  }

  Future<void> fetchSchedule() async {
    var url = 'https://flutter.otaiwebsite.com/api/schedule_guard_data.php?id=$authToken';

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<GuardScheduleModel> loadedData = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (controlData) {
        loadedData.add(
          GuardScheduleModel(
            scheduleId: controlData['schedule_id'],
            guardId: controlData['guard_id'],
            controlStartTime: controlData['schedule_start'],
            controlEndTime: controlData['schedule_end'],
          ),
        );

        _schedule = loadedData;
        notifyListeners();
      },
    );
  }
}
