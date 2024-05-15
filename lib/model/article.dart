class ArticleModel{
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  bool? bookmark;
  // String publishedAt;
  
  ArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.bookmark,
    // required this.publishedAt,
  });
}