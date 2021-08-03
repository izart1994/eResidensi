import 'dart:ui';

import '../screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rich_alert/rich_alert.dart';

import '../providers/auth_providers.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  double _height;
  double _width;
  String _token;

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  bool _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    // Log user in
    await Provider.of<AuthProviders>(context, listen: false).authenticate(
      _authData['username'],
      _authData['password'],
    );

    final authData = Provider.of<AuthProviders>(context, listen: false);
    _token = authData.token;

    if (_token == null) {
      setState(() {
        _isLoading = false;
      });
      return _alert();
    }
  }

  _alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RichAlertDialog(
          alertTitle: richTitle("Gagal"),
          alertSubtitle:
              richSubtitle("Nama Pengguna dan Kata Laluan tidak sepadan!"),
          alertType: RichAlertType.ERROR,
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.cyan,
              child: Text(
                "Okay",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: _height * 0.15,
        child: Image.asset('assets/images/logo_transparent.png'),
      ),
    );

    final _username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Nama Pengguna',
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama Pengguna Tak Sah!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['username'] = value;
      },
    );

    final _password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Kata Laluan',
        labelStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      controller: _passwordController,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value.isEmpty || value.length < 5) {
          return 'Kata Laluan Terlalu Pendek!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value;
      },
    );

    final _forgotLabel = FlatButton(
      child: Text(
        'Lupa Kata Laluan?',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
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
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    logo,
                    SizedBox(height: 20.0),
                    _username,
                    SizedBox(height: 8.0),
                    _password,
                    SizedBox(height: 24.0),
                    _isLoading
                        ? SpinKitDoubleBounce(
                            color: Color.fromRGBO(255, 255, 255, 0.4),
                            size: 40.0,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: _submit,
                              padding: EdgeInsets.all(12),
                              color: Colors.cyan,
                              child: Text(
                                'Log Masuk',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    _forgotLabel,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: _height * 0.08,
        color: Colors.cyan,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(Splash.routeName),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'eResidensi Ads',
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
