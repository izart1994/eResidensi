import 'package:eResidensi/screen/qr_code.dart';
import 'package:eResidensi/screen/schedule.dart';

import '../screen/self_info.dart';
import '../screen/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 11,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SelfInfo.routeName);
                  print('Test 1');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/fat-cop.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Info Diri",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Schedule.routeName);
                  print('test 2');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/schedule.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Penjadualan",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(QrCode.routeName);
                  print('Test 3');
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
              Flexible(
                child: Text(
                  "QR Kod",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(News.routeName);
                  print('test 4');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/news.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Berita",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  FlutterOpenWhatsapp.sendSingleMessage(
                      "+601114916154", "Notis");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/comments.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "WhatsApp",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
