import 'package:eResidensi/screen_child/guard_control.dart';
import 'package:eResidensi/screen_child/schedule_info_daily.dart';
import 'package:flutter/material.dart';

class ScheduleDivision extends StatefulWidget {
  final String tab;

  ScheduleDivision({Key key, this.tab}) : super(key: key);

  @override
  ScheduleDivisionState createState() => ScheduleDivisionState();
}

class ScheduleDivisionState extends State<ScheduleDivision>
    with AutomaticKeepAliveClientMixin<ScheduleDivision> {
  @override
  void initState() {
    super.initState();
    print("created");
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: widget.tab == 'Jadual Harian'
          ? ScheduleInfoDaily()
          : GuardControl(
              page: 2,
            ),
    );
  }
}
