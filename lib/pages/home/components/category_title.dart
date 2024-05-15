import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/home/components/category_news.dart';

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  const CategoryTile({
    super.key,
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: kLessPadding),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 200,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                categoryName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold, // Make bold
                      fontSize: 25, // Increase font size
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
