import 'package:eResidensi/screen_child/guard_info_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import '../models/guard_model.dart';

class GuardInfoOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final guardData = Provider.of<GuardModel>(context, listen: false);
    String _guardId = guardData.guardId;
    String _guardName = guardData.guardName;
    String _guardNokp = guardData.guardNokp;
    String _guardUsername = guardData.guardUsername;
    String _guardPassword = guardData.guardPassword;

    popUpInfo() {
      return showMaterialResponsiveDialog(
        context: context,
        title: 'Kemaskini Info Diri',
        headerTextColor: Colors.white,
        child: Center(
          child: GuardInfoEdit(_guardId, _guardName, _guardNokp, _guardUsername),
        ),
      );
    }

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Nama : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 0.90,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _guardName,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.90,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'No IC :  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 0.90,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _guardNokp,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.90,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Nama Pengguna :  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 0.90,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _guardUsername,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.90,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Kata Laluan :  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 0.90,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _guardPassword,
                          style: TextStyle(
                            fontSize: 16,
                            height: 0.90,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: _height * 0.02,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: Colors.cyan,
          child: Text(
            "Kemaskini Info",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            popUpInfo();
          },
        ),
      ],
    );
  }
}
