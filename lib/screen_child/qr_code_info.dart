import 'package:eResidensi/providers/qrcode_providers.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class QrCodeInfo extends StatefulWidget {
  const QrCodeInfo({Key key}) : super(key: key);

  @override
  _QrCodeInfoState createState() => _QrCodeInfoState();
}

class _QrCodeInfoState extends State<QrCodeInfo> {
  var location = new Location();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _title;
  String _id;
  String _detail;
  String _result;
  String _latitude;
  String _longitude;
  PermissionStatus _permissionGranted;
  Map<String, double> userLocation;
  ScanResult scanResult;

  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  // ignore: type_annotate_public_apis
  initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }

  Future scan() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

      geolocator.getCurrentPosition().then((Position position) {
        setState(() {
          _latitude = "${position.latitude}";
          _longitude = "${position.longitude}";
        });
      }).catchError((e) {
        print(e);
      });
    }

    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);
      String kodcontent = result.rawContent;
      setState(() => scanResult = result);
      if (kodcontent == "" || kodcontent == null) {
        _title = "Tidak Berjaya";
        _result = "Tiada Qr kod disemak";
      } else if (kodcontent != "" || kodcontent != null) {
        setState(() {
          _detail = kodcontent;
        });
        await Provider.of<QrCodeProviders>(context).qrauthenticate(
          _detail,
          _latitude,
          _longitude,
        );

        final qrData = Provider.of<QrCodeProviders>(context);
        setState(() {
          _id = qrData.id;
          if (_id == "unseccessful") {
            _title = "Tidak Berjaya";
          } else {
            _title = "Berjaya";
          }
          _result = qrData.detail;
        });
      } else {
        _title = "Tidak Berjaya";
        _result = "Tidak dapat kebenaran bagi kamera!";
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          _title = "Tidak Berjaya";
          _result = "Tidak dapat kebenaran bagi kamera!";
        });
      } else {
        _title = "Tidak Berjaya";
        _result = 'Masalah tidak diketahui: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var contentList = <Widget>[
      scanResult != null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Semak QR Kod",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.only(
                      right: 10.0,
                      left: 10.0,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            _title!=null?_title:"Memproses Data",
                            //_title != "" ? _title : "Tidak Berjaya",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            _result!=null?_result:"",
                            // _result != ""
                            //     ? _result
                            //     : "Tidak dapat kebenaran bagi kamera!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Semak QR Kod",
                  ),
                ],
              ),
            )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  scan();
                  print('scan');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/iris-scan.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: contentList,
        ),
      ],
    );
  }
}
