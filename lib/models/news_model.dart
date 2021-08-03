import 'package:flutter/foundation.dart';

class NewsModel with ChangeNotifier {
  final String newsId;
  final String userId;
  final String newsTitle;
  final String newsContent;
  final String newsAdded;

  NewsModel({
    this.newsId,
    this.userId,
    this.newsTitle,
    this.newsContent,
    this.newsAdded,
  });
}
