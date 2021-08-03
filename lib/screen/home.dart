import 'dart:ui';

import '../providers/news_provider.dart';
import '../screen_child/news_info_one.dart';
import '../widgets/icon_awesome4_icons.dart';
import '../widgets/menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  Home({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  double _height;
  double _width;
  bool _isInit = true;
  bool _isLoading = true;

  TextStyle labelTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<NewsProviders>(context).fetchNewsData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final news = Provider.of<NewsProviders>(context, listen: false);
    final newsAll = news.newsData;

    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _width,
                height: _height * 0.30,
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: DiagonalPathClipperTwo(),
                      child: Container(
                        width: _width,
                        height: _height * 0.25,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new ExactAssetImage(
                                'assets/images/residential_one.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: new BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
                          child: new Container(
                            decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.25,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      "assets/images/verified-account.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.width * 0.24,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      IconAwesome4.home_1,
                                      size: 40,
                                      color: Colors.cyan[700],
                                    ),
                                    TypewriterAnimatedTextKit(
                                      onTap: () {
                                        print("Tap Event");
                                      },
                                      text: [
                                        'Residensi Bukit Subang',
                                        'Residensi Bukit Subang',
                                        'Residensi Bukit Subang',
                                      ],
                                      textStyle: labelTextStyle,
                                      textAlign: TextAlign.start,
                                      alignment: AlignmentDirectional.topStart,
                                      isRepeatingAnimation: true,
                                      repeatForever: true,
                                      speed: Duration(milliseconds: 400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.005,
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Paparan Utama',
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.005,
                  ),
                  MenuList(),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Berita Terkini',
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.005,
                  ),
                  _isLoading
                      ? SpinKitDoubleBounce(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          size: 40.0,
                        )
                      : Container(
                          height: _height / 4.25,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(3),
                            itemCount: newsAll.length,
                            itemBuilder: (context, index) =>
                                ChangeNotifierProvider.value(
                              value: newsAll[index],
                              child: NewsInfoOne(),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
