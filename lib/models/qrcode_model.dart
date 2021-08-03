import 'package:flutter/foundation.dart';

class QRCode with ChangeNotifier {
  final String id;
  final String detail;

  QRCode({
    this.id,
    this.detail,
  });
}
