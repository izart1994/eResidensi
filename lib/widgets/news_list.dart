import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 11,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('Test 1');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/documents.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Umum",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //Navigator.of(context).pushNamed(PROPERTIES_ITEM_LIST);
                  print('test 2');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/money-transfer.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Notis bayaran",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('Test 3');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/work.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Notis Fasiliti",
                  style: textStyle,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //Navigator.of(context).pushNamed(JOBS_ITEM_LIST);
                  print('test 4');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.width * 0.20,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage("assets/images/online-support.png"),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  "Notis Sistem",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
