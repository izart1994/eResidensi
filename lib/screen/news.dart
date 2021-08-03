import '../providers/news_provider.dart';
import '../screen_child/news_info_one.dart';
import '../widgets/news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  static const routeName = '/news';
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  double _height;
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
      Provider.of<NewsProviders>(context).fetchNewsData().then((_) {
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
    _height = MediaQuery.of(context).size.height;

    final news = Provider.of<NewsProviders>(context, listen: false);
    final newsAll = news.newsData;

    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: SafeArea(
        child: AnimatedContainer(
          color: Colors.cyan[100],
          duration: Duration(seconds: 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                NewsList(),
                Divider(),
                SizedBox(
                  height: _height * 0.005,
                ),
                _isLoading
                    ? SpinKitDoubleBounce(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        size: 40.0,
                      )
                    : Container(
                        height: _height,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(3),
                          itemCount: newsAll.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                            value: newsAll[index],
                            child: NewsInfoOne(),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
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
    );
  }
}
