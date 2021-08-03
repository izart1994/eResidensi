import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    TextStyle labelTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    final _logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: _height * 0.08,
        child: Image.asset('assets/images/warning.png'),
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _logo,
        SizedBox(
          height: _height * 0.05,
        ),
        Text(
          'Adakah anda pasti ingin log keluar daripada sistem?',
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: _height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                Provider.of<AuthProviders>(context, listen: false).signOut();
              },
            ),
            SizedBox(
              width: _width * 0.05,
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
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}
