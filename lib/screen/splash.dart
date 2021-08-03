import 'dart:ui';

import '../widgets/icon_awesome4_icons.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static const routeName = '/splash';
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    TextStyle textStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.normal,
      color: Colors.white,
    );

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: _height * 0.15,
        child: Image.asset('assets/images/logo_transparent.png'),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              height: _height,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image:
                      new ExactAssetImage('assets/images/residential_two.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0.0),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
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
                      SizedBox(width: 20.0),
                      Flexible(
                        child: Text(
                          "Keselamatan yang lebih terjamin",
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
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
                      SizedBox(width: 20.0),
                      Flexible(
                        child: Text(
                          "Berita perumahan anda secara menyeluruh",
                          style: textStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: _height * 0.08,
        color: Colors.cyan,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  IconAwesome4.login,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Log Masuk',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
