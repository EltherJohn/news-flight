import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/model/article.dart';
import 'package:nf_og/pages/home/components/blog_tile.dart';
import 'package:nf_og/services/category.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({
    super.key,
    required this.category,
  });

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  void getCategoryNews() async {
    GetCategoryNews news = GetCategoryNews();
    await news.getNews(widget.category.toLowerCase());
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkColor,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.category,
              style: kHeadTextStyle,
            ),
          ],
        ),
      ),
      backgroundColor: kDarkColor,
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  return BlogTile(
                    imageUrl: articles[index].urlToImage as String,
                    title: articles[index].title as String,
                    desc: articles[index].description as String,
                    url: articles[index].url as String,
                    bm: bm,
                    function: (){},
                    articles: articles,
                    index: index,
                    isBookmark: articles[index].bookmark as bool,
                  );
                }),
              ),
            ),
          ),
    );
  }
}
