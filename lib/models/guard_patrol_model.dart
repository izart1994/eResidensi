import 'package:flutter/foundation.dart';

class GuardPatrolModel with ChangeNotifier {
  final String controlId;
  final String controlSession;
  final String controlDate;
  final String controlStartTime;
  final String controlEndTime;

  GuardPatrolModel({
    this.controlId,
    this.controlSession,
    this.controlDate,
    this.controlStartTime,
    this.controlEndTime,
  });

  factory GuardPatrolModel.fromJson(Map<String, dynamic> json) {
    return GuardPatrolModel(
      controlId: json["control_id"] as String,
      controlSession: json["control_session"] as String,
      controlDate: json["control_date"] as String,
      controlStartTime: json["control_start_time"] as String,
      controlEndTime: json["control_end_time"] as String,
    );
  }
}
