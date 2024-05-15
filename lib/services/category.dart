import 'package:nf_og/model/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCategoryNews {
  List<ArticleModel> news = [];
  String countryCode = 'us';

  Future<void> getNews(String category) async {
    Uri url = Uri.parse("https://newsapi.org/v2/top-headlines?country=$countryCode&category=$category&apiKey=780c7b6a7e924552a16df98fafd48718");

    var response = await http.get(url);

    Map jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            // publishedAt: element['publishedAt'],
            content: element['context'],
            bookmark: false,
          );
          
          news.add(articleModel);
        }
      });
    }
  }
}
