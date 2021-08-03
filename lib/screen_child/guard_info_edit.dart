import 'package:eResidensi/models/guard_model.dart';
import 'package:eResidensi/providers/guard_info_providers.dart';
import 'package:eResidensi/screen/self_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rich_alert/rich_alert.dart';

class GuardInfoEdit extends StatefulWidget {
  final String id;
  final String name;
  final String nokp;
  final String username;

  GuardInfoEdit(
    this.id,
    this.name,
    this.nokp,
    this.username,
  );

  @override
  _GuardInfoEditState createState() => _GuardInfoEditState();
}

class _GuardInfoEditState extends State<GuardInfoEdit> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameFocusNode = FocusNode();
  final _nokpFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedData = GuardModel(
    guardId: null,
    guardName: '',
    guardNokp: '',
    guardUsername: '',
  );
  var _isLoading = false;

  @override
  void dispose() {
    _nokpFocusNode.dispose();
    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    //final guardId = ModalRoute.of(context).settings.arguments as String;
    final guardId = widget.id;
    if (guardId != null) {
      try {
        await Provider.of<GuardInfoProviders>(context).updateGuardData(
            guardId,
            _editedData.guardName,
            _editedData.guardNokp,
            _editedData.guardUsername);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return RichAlertDialog(
              alertTitle: richTitle("Gagal"),
              alertSubtitle: richSubtitle("Masalah berlaku!"),
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
    }
    setState(() {
      _isLoading = false;
    });
    //Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(SelfInfo.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SpinKitDoubleBounce(
                  color: Colors.cyan[100],
                  size: 40.0,
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: [
                    Form(
                      key: _form,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            initialValue: widget.name,
                            decoration:
                                InputDecoration(labelText: 'Nama Penuh'),
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Sila masukkan maklumat';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData = GuardModel(
                                guardName: value,
                                guardNokp: _editedData.guardNokp,
                                guardUsername: _editedData.guardUsername,
                              );
                            },
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            initialValue: widget.nokp,
                            decoration: InputDecoration(labelText: 'No KP'),
                            textInputAction: TextInputAction.next,
                            focusNode: _nokpFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Sila masukkan maklumat';
                              }
                              if (value.length < 7) {
                                return 'Sila masukkan sekurangnya 7 askara';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData = GuardModel(
                                guardName: _editedData.guardName,
                                guardNokp: value,
                                guardUsername: _editedData.guardUsername,
                              );
                            },
                          ),
                          TextFormField(
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            initialValue: widget.username,
                            decoration:
                                InputDecoration(labelText: 'Nama Pengguna'),
                            textInputAction: TextInputAction.next,
                            focusNode: _usernameFocusNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Sila masukkan maklumat nama pengguna';
                              }
                              if (value.length < 5) {
                                return 'Sila masukkan maklumat sekurangnya 5 askara';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedData = GuardModel(
                                guardName: _editedData.guardName,
                                guardNokp: _editedData.guardNokp,
                                guardUsername: value,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                            _saveForm();
                          },
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
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
