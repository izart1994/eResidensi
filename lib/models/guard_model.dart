import 'package:flutter/foundation.dart';

class GuardModel with ChangeNotifier {
  final String guardId;
  final String guardName;
  final String guardNokp;
  final String guardUsername;
  final String guardPassword;

  GuardModel({
    this.guardId,
    this.guardName,
    this.guardNokp,
    this.guardUsername,
    this.guardPassword,
  });
}
