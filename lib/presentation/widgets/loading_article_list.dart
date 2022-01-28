import 'package:flutter/material.dart';
import 'package:headline_news/common/theme.dart';
import 'package:shimmer/shimmer.dart';

class LoadingArticleList extends StatelessWidget {
  const LoadingArticleList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFa1a1a1),
      highlightColor: Color(0xFFe1e1e1),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
          key: Key('article_list_item'),
          margin: EdgeInsets.only(
            bottom: 16,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(
            children: [
            Container(
              width: 110,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[500],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: Container(
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: Container(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          ]),
        );
        },
        itemCount: 7,
      )
    );
  }
}