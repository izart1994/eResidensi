import 'package:eResidensi/screen_child/guard_control.dart';
import 'package:eResidensi/screen_child/qr_code_info.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';
import 'package:rich_alert/rich_alert.dart';

import '../screen/log_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../screen/home.dart';
import 'icon_awesome4_icons.dart';

class NavigationBar extends StatefulWidget {
  static const routeName = '/';

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedItemPosition = 0;
  SnakeBarStyle snakeBarStyle = SnakeBarStyle.floating;
  SnakeShape snakeShape = SnakeShape.circle;
  ShapeBorder bottomBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  );
  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color backgroundColor = Colors.white;

  Gradient backgroundGradient =
      const LinearGradient(colors: [Colors.black, Colors.lightBlue]);
  Gradient selectionGradient =
      const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]);

  EdgeInsets padding = EdgeInsets.all(12);
  //Color containerColor = Color(0xFFFDE1D7);
  Color containerColor = Colors.cyan[100];
  TextStyle labelTextStyle = TextStyle(
    fontSize: 11,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _outPressed,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: containerColor,
        body: AnimatedContainer(
          color: containerColor,
          duration: Duration(seconds: 1),
          child: _getPage(_selectedItemPosition),
        ),
        bottomNavigationBar: SnakeNavigationBar(
          style: snakeBarStyle,
          snakeShape: snakeShape,
          snakeColor: Colors.cyan[700], //comment if you want to see colors
          backgroundColor: backgroundColor, //comment if you want to see colors
//        snakeGradient: selectionGradient, //uncomment if you want to see gradients
//        backgroundGradient: backgroundGradient, //uncomment if you want to see gradients
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
//        selectedItemColor: Colors.amber,
//        selectedItemGradient: LinearGradient(colors: [Colors.blue[900],Colors.blue[200]]),
          shape: bottomBarShape,
          padding: padding,
          currentIndex: _selectedItemPosition,
          onPositionChanged: (index) =>
              setState(() => _selectedItemPosition = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                IconAwesome4.home_1,
              ),
              title: Text(
                'utama',
                style: labelTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconAwesome4.calendar,
              ),
              title: Text(
                'kawalan',
                style: labelTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconAwesome4.camera_retro,
              ),
              title: Text(
                'qr kod',
                style: labelTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconAwesome4.sign_out_alt,
              ),
              title: Text(
                'keluar',
                style: labelTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _outPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return RichAlertDialog(
          alertTitle: richTitle("Perhatian!"),
          alertSubtitle: richSubtitle(
              "Adakah anda pasti ingin log keluar daripada sistem?"),
          alertType: RichAlertType.WARNING,
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.red,
              child: Text(
                "Okay",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<AuthProviders>(context, listen: false).signOut();
              },
            ),
            SizedBox(
              width: 5,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.cyan,
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  _getPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return GuardControl(
          page: 1,
        );
      case 2:
        return QrCodeInfo();
      case 3:
        return LogOut();
    }
  }
}
