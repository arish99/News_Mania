import 'dart:convert';

import 'package:news_mania/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=472a42bf43894b4392f889f6bc0f3b3a';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: element['author'],
            url: element['url'],
            urltoImage: element['urlToImage'],
            description: element['description'],
            title: element['title'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    } else {
      print('Not good');
    }
  }
}

class CategoryClass {
  List<ArticleModel> news = [];
  Future<void> getCategoryNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=472a42bf43894b4392f889f6bc0f3b3a';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: element['author'],
            url: element['url'],
            urltoImage: element['urlToImage'],
            description: element['description'],
            title: element['title'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    } else {
      print('Not good');
    }
  }
}

//jsonData['status'] == 'ok'
