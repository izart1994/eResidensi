import '../models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_alert/flutter_alert.dart';

class NewsInfoOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    final newsData = Provider.of<NewsModel>(context, listen: false);
    String _newsTitle = newsData.newsTitle;
    String _newsContent = newsData.newsContent;
    String _newsAdded = newsData.newsAdded;

    var _newsAddedConverted = int.parse(_newsAdded);

    String readTimestamp(int timestamp) {
      var now = DateTime.now();
      var format = DateFormat('MMM d, h:mm a');
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var diff = now.difference(date);
      var time = '';

      if (diff.inSeconds <= 0 ||
          diff.inSeconds > 0 && diff.inMinutes == 0 ||
          diff.inMinutes > 0 && diff.inHours == 0 ||
          diff.inHours > 0 && diff.inDays == 0) {
        time = format.format(date);
      } else if (diff.inDays > 0 && diff.inDays < 7) {
        if (diff.inDays == 1) {
          time = diff.inDays.toString() + ' Hari Lalu';
        } else {
          time = diff.inDays.toString() + ' Hari Lalu';
        }
      } else {
        if (diff.inDays == 7) {
          time = (diff.inDays / 7).floor().toString() + ' Minggu Lalu';
        } else {
          time = (diff.inDays / 7).floor().toString() + ' Minggu Lalu';
        }
      }
      return time;
    }

    _showDialog(BuildContext context) {
      showAlert(
        context: context,
        title: _newsTitle,
        body: _newsContent,
        ownColor: Colors.blue,
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _showDialog(context);
        },
        child: Container(
          height: _height * 0.15,
          padding: EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 7.0,
                height: 550.0,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: _width / 1.6,
                        child: Text(
                          _newsTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _height / 39,
                            fontFamily: 'Ubuntu',
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        width: _width / 4.2,
                        child: Text(
                        "     [" + readTimestamp(_newsAddedConverted) + "]",
                        style: TextStyle(
                          fontSize: _height / 65,
                          fontFamily: 'Ubuntu',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      ),
                    ],
                  ),
                  Container(
                    width: _width / 1.3,
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      _newsContent,
                      style: TextStyle(
                        fontSize: _height / 45,
                        fontFamily: 'Ubuntu',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '(Tekan untuk bacaan lanjut)',
                    style: TextStyle(
                      fontSize: _height / 70,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
