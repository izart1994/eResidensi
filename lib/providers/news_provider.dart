import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class NewsProviders with ChangeNotifier {
  List<NewsModel> _newsData = [];

  List<NewsModel> get newsData {
    return _newsData;
  }

  Future<void> fetchNewsData() async {
    var url =
        'https://flutter.otaiwebsite.com/api/news.php';

    final response = await http.get(url);
    print(response);
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<NewsModel> loadedData = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach(
      (newsData) {
        loadedData.add(
          NewsModel(
            newsId: newsData['news_id'],
            userId: newsData['user_id'],
            newsTitle: newsData['news_title'],
            newsContent: newsData['news_content'],
            newsAdded: newsData['news_added'],
          ),
        );
        _newsData = loadedData;
        notifyListeners();
      },
    );
  }
}