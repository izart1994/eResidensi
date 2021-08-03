import 'package:eResidensi/models/guard_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleInfoDailyOne extends StatelessWidget {
  const ScheduleInfoDailyOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    final newsData = Provider.of<GuardScheduleModel>(context, listen: false);
    String _startTime = newsData.controlStartTime;
    String _endTime = newsData.controlEndTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 2,
          color: Colors.cyan[100],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.fiber_smart_record,
              color: Colors.cyan,
            ),
            Container(
              width: _width / 1.6,
              child: Text(
                _startTime + " - " + _endTime,
                style: TextStyle(
                  fontSize: _height / 39,
                  fontFamily: 'Ubuntu',
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
