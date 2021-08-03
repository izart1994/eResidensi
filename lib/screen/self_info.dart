import 'package:eResidensi/providers/guard_info_providers.dart';
import 'package:eResidensi/screen_child/guard_info_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SelfInfo extends StatefulWidget {
  static const routeName = '/self_info';
  SelfInfo({Key key}) : super(key: key);

  @override
  _SelfInfoState createState() => _SelfInfoState();
}

class _SelfInfoState extends State<SelfInfo> {
  var _isInit = true;
  var _isLoading = true;

  TextStyle labelTextStyle = TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    color: Colors.white,
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
      Provider.of<GuardInfoProviders>(context).fetchGuardData().then((_) {
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
    final guard = Provider.of<GuardInfoProviders>(context, listen: false);
    final guardId = guard.guardData;

    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Info Diri',
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: AnimatedContainer(
            color: Colors.cyan[100],
            duration: Duration(seconds: 1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                  _isLoading
                      ? SpinKitDoubleBounce(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          size: 40.0,
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 15, top: 0, right: 15, bottom: 0),
                          itemCount: guardId.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                            value: guardId[index],
                            child: GuardInfoOne(),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
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
