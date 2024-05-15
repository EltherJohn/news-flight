import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/model/article.dart';
import 'package:nf_og/pages/comment/comment.dart';
import 'package:nf_og/pages/home/components/arcticle_view.dart';

class BlogTile extends StatefulWidget {
  final String imageUrl, title, desc, url;
  final List<ArticleModel> bm;
  final List<ArticleModel> articles;
  final VoidCallback function;
  final int index;
  bool isBookmark;

  BlogTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
    required this.function,
    required this.bm,
    required this.articles,
    required this.index,
    required this.isBookmark,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  
  //* toggle icon
  Icon togggleIcon() {

    return Icon(
      (!widget.isBookmark) ? Icons.bookmark_add : Icons.bookmark_added,
      color: Colors.amber,
      size: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ArticleView(
              blogUrl: widget.url,
            );
          }));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: kDefaultPadding),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultRadius),
                child: Stack(
                  children: [
                    Image.network(widget.imageUrl),
                    Positioned(
                      top: 10,
                      right: 5,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            final user = FirebaseFirestore.instance
                                .collection('users')
                                .doc(
                                    '${FirebaseAuth.instance.currentUser?.uid}');

                            if (bmArticles[widget.title] == null) {
                              ArticleModel articleModel = ArticleModel(
                                title: widget.title,
                                author: '',
                                description: widget.desc,
                                url: widget.url,
                                urlToImage: widget.imageUrl,
                                content: null,
                                bookmark: true,
                              );

                              setState(() {
                                //* add news info to the firebase
                                bmArticles[widget.title] = {
                                  'author': '',
                                  'description': widget.desc,
                                  'url': widget.url,
                                  'urlToImage': widget.imageUrl,
                                  'content': null,
                                  'bookmark': true,
                                };
                                widget.bm.add(articleModel);
                                widget.isBookmark =
                                    glbArticles[widget.index].bookmark = true;

                                Flushbar(
                                  dismissDirection:
                                      FlushbarDismissDirection.HORIZONTAL,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  reverseAnimationCurve: Curves.decelerate,
                                  forwardAnimationCurve: Curves.elasticOut,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  isDismissible: true,
                                  message: 'Added to Bookmarks',
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color: Colors.blue[300],
                                  ),
                                  duration: const Duration(seconds: 2),
                                  leftBarIndicatorColor: kLightColor,
                                ).show(context);
                              });
                            } else {
                              setState(() {
                                // bmArticles[widget.title] = null;

                                widget.isBookmark =
                                    glbArticles[widget.index].bookmark = false;

                                //* removing news article info from the database
                                bmArticles.remove(widget.title);

                                for (int i = 0; i < widget.bm.length; ++i) {
                                  if (widget.bm[i].title == widget.title) {
                                    widget.bm.remove(widget.bm[i]);
                                  }
                                }
                                Flushbar(
                                  dismissDirection:
                                      FlushbarDismissDirection.HORIZONTAL,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  reverseAnimationCurve: Curves.decelerate,
                                  forwardAnimationCurve: Curves.elasticOut,
                                  flushbarPosition: FlushbarPosition.TOP,
                                  isDismissible: true,
                                  message: 'Removed from Bookmarks',
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28.0,
                                    color: Colors.blue[300],
                                  ),
                                  duration: const Duration(seconds: 2),
                                  leftBarIndicatorColor: kLightColor,
                                ).show(context);
                                // widget.bm.remove(widget.bm[widget.index]);
                              });
                            }
                            bm = widget.bm;

                            //* updating database
                            user.update({
                              'bookmark': bmArticles,
                            });

                            //* rebuild function.
                            widget.function();
                          },
                          icon: togggleIcon(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Comment(title: widget.title),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.comment,
                            color: Colors.amber,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.title,
                style: kLightTextStyle,
              ),
              Text(
                widget.desc,
                style: kSmallTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
