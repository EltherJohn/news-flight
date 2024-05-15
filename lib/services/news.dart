import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/model/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  String countryCode = 'us';

  Future<void> getNews() async {
    Uri url = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=745abcfdc7cd47208777b0d4a7a63825");

    var response = await http.get(url);

    Map jsonData = jsonDecode(response.body);
    
    // allArticles = jsonData['status']['articles'] as Map<String, dynamic>;
    

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
          
          allArticles[element['title']] = {
            'author': element['author'],
            'description': element['description'],
            'url': element['url'],
            'urlToImage': element['urlToImage'],
            // publishedAt: element['publishedAt'],
            'content': element['context'],
            'bookmark': false,
          };
          
          news.add(articleModel);
        }
      });
    }
    
    
    // allArticles.
    
    
    glbArticles = news;
    
    // print(bmArticles);
    
    // glbArticles.forEach((element) {
    //   if(element.)
    // });
    
    for (var key in bmArticles.keys) {
      for(int i = 0; i < glbArticles.length; ++i){
        if(glbArticles[i].title == key){
          glbArticles[i].bookmark = true;
        }
      }
    }
    
    FirebaseFirestore.instance.collection('articles').doc('categories').update({
      'general': allArticles,
      'total': allArticles.length,
    });
    
    // return news;
  }
  

}
