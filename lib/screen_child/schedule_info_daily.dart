import 'package:eResidensi/providers/guard_schedule_providers.dart';
import 'package:eResidensi/screen_child/schedule_info_daily_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ScheduleInfoDaily extends StatefulWidget {
  static const routeName = '/schedule_info_daily';
  ScheduleInfoDaily({Key key}) : super(key: key);

  @override
  _ScheduleInfoDailyState createState() => _ScheduleInfoDailyState();
}

class _ScheduleInfoDailyState extends State<ScheduleInfoDaily> {
  bool _isInit = true;
  bool _isLoading = true;

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
      Provider.of<GuardScheduleProviders>(context).fetchSchedule().then((_) {
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
    double _height = MediaQuery.of(context).size.height;
    final schedule =
        Provider.of<GuardScheduleProviders>(context, listen: false);
    final scheduleAll = schedule.schedule;

    return SafeArea(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
            child: _isLoading
                ? SpinKitDoubleBounce(
                    color: Colors.cyan,
                    size: 40.0,
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: _height * 0.65,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(3),
                        itemCount: scheduleAll.length,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                          value: scheduleAll[index],
                          child: ScheduleInfoDailyOne(),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
