import 'package:eResidensi/models/guard_patrol_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuardControlOne extends StatelessWidget {
  const GuardControlOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final patrol = Provider.of<GuardPatrolModel>(context, listen: false);
    String session = patrol.controlSession;
    String startTime = patrol.controlStartTime;
    String endTime = patrol.controlEndTime;

    if (endTime == null) {
      endTime = "belum tamat";
    } else if (endTime == "gagal") {
      endTime = "gagal patuhi waktu";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Waktu $session",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _height / 40,
            color: Colors.black,
            fontFamily: 'Ubuntu',
          ),
        ),
        Container(
          width: _width / 1.4,
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  "Masa: $startTime - $endTime",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
          color: Colors.cyan[100],
        ),
      ],
    );
  }
}
