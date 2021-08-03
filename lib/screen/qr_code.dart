import 'package:eResidensi/screen_child/qr_code_info.dart';
import 'package:flutter/material.dart';

class QrCode extends StatefulWidget {
  static const routeName = '/qr_code';
  QrCode({Key key}) : super(key: key);

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  TextStyle labelTextStyle = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'QR Kod',
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: QrCodeInfo(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
        child: new ConstrainedBox(
          constraints: new BoxConstraints.expand(),
          child: new Image.asset(
            'assets/images/back.png',
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}
