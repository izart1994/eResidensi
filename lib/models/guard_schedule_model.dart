import 'package:flutter/foundation.dart';

class GuardScheduleModel with ChangeNotifier {
  final String scheduleId;
  final String guardId;
  final String controlStartTime;
  final String controlEndTime;

  GuardScheduleModel({
    this.scheduleId,
    this.guardId,
    this.controlStartTime,
    this.controlEndTime,
  });
}
