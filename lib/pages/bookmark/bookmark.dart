import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/model/article.dart';
import 'package:nf_og/pages/home/components/blog_tile.dart';
import 'package:provider/provider.dart';
import 'package:nf_og/theme/theme_provider.dart';

class Bookmark extends StatefulWidget {
  final List<ArticleModel> bm;
  const Bookmark({Key? key, required this.bm}) : super(key: key);

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  //* loads the screen
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {});
    });
    super.initState();
  }
  
  //* generate bookmark articles
  SingleChildScrollView genBMArticles() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: widget.bm.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return BlogTile(
                imageUrl: widget.bm[index].urlToImage as String,
                title: widget.bm[index].title as String,
                desc: widget.bm[index].description as String,
                url: widget.bm[index].url as String,
                bm: widget.bm,
                articles: glbArticles,
                function: () {
                  setState(() {});
                },
                index: index,
                isBookmark: widget.bm[index].bookmark as bool,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      body: (widget.bm.isEmpty)
          ? Center(
              child: Text('No Articles Saved', style: themeData.textTheme.bodyText2),
            )
          : genBMArticles(),
    );
  }
}
