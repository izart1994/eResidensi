import 'package:eResidensi/providers/guard_patrol_providers.dart';
import 'package:eResidensi/screen_child/guard_control_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class GuardControl extends StatefulWidget {
  static const routeName = '/schedule_info_daily';
  final int page;
  GuardControl({Key key, this.page}) : super(key: key);

  @override
  _GuardControlState createState() => _GuardControlState();
}

class _GuardControlState extends State<GuardControl> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  dynamic test;

  var _isInit = true;
  var _isLoading = true;

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
      Provider.of<GuardPatrolProviders>(context).fetchPatrol().then((_) {
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
    final controlData =
        Provider.of<GuardPatrolProviders>(context, listen: false);
    final _controlData = controlData.items;
    _height = MediaQuery.of(context).size.height;

    TextStyle labelTextStyle = TextStyle(
      fontSize: _height / 30,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.bold,
      color: Colors.cyan,
    );

    return SafeArea(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Column(
          children: [
            widget.page == 1
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.width * 0.20,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage("assets/images/last-24-hours.png"),
                      ),
                    ),
                  )
                : Container(
                    child: null,
                  ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
                child: _isLoading
                    ? SpinKitDoubleBounce(
                        color: Colors.cyan,
                        size: 40.0,
                      )
                    : SingleChildScrollView(
                        child: Container(
                          height: _height * 0.65,
                          child: _controlData.length == 0 ||
                                  _controlData.length == -1
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        'Belum ada data pengawalan',
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      left: 10, top: 5, right: 10, bottom: 10),
                                  itemCount: _controlData.length,
                                  itemBuilder: (context, index) =>
                                      ChangeNotifierProvider.value(
                                    value: _controlData[index],
                                    child: GuardControlOne(),
                                  ),
                                ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
