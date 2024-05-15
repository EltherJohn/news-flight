import 'package:firebase_auth/firebase_auth.dart';
import 'package:nf_og/model/article.dart';
import 'package:nf_og/model/catergory.dart';
import 'package:nf_og/pages/home/components/blog_tile.dart';
import 'package:nf_og/services/data.dart';
import 'package:nf_og/pages/home/components/category_title.dart';
import 'package:nf_og/constant.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/services/news.dart';

class Home extends StatefulWidget {
  List<ArticleModel> articles;

  Home({super.key, required this.articles});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  List<CategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    widget.articles = news.news;
    glbArticles = news.news;

    setState(() {
      _loading = false;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: kDarkColor,
      body: (_loading)
          ? GestureDetector(
              child: Center(
                child: Container(
                  child: const CircularProgressIndicator(),
                ),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.articles.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return BlogTile(
                        imageUrl: widget.articles[index].urlToImage as String,
                        title: widget.articles[index].title as String,
                        desc: widget.articles[index].description as String,
                        url: widget.articles[index].url as String,
                        bm: bm,
                        function: () {},
                        articles: widget.articles,
                        index: index,
                        isBookmark: widget.articles[index].bookmark as bool,
                      );
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
