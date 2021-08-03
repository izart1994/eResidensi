import 'package:eResidensi/screen_child/schedule_division.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  static const routeName = '/schedule';
  const Schedule({Key key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          backgroundColor: Colors.cyan[100],
          body: SafeArea(
            child: AnimatedContainer(
              color: Colors.cyan[100],
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabBar(
                          indicatorColor: Colors.cyan,
                          isScrollable: true,
                          tabs: choices.map((Choice choice) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: Tab(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.20,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new AssetImage(choice.image),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        choice.title,
                                        style: labelTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: choices.map((Choice choice) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ScheduleDivision(tab: choice.title),
                        );
                      }).toList(),
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }
}

class Choice {
  Choice({this.title, this.image, this.liststring, this.function});

  final String title;
  final String image;
  List<String> liststring; //= new List();
  final Function function;
}

List<Choice> choices = <Choice>[
  Choice(
    title: 'Jadual Harian',
    image: 'assets/images/planner.png',
    liststring: ["1"],
  ),
  Choice(
    title: 'Pengawalan Hari Ini',
    image: 'assets/images/last-24-hours.png',
    liststring: ["2"],
  ),
];
