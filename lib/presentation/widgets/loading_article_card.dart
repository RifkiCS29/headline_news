import 'package:flutter/material.dart';
import 'package:headline_news/common/theme.dart';
import 'package:shimmer/shimmer.dart';

class LoadingArticleCard extends StatelessWidget {
  const LoadingArticleCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFa1a1a1),
      highlightColor: const Color(0xFFe1e1e1),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              (index == 0) ? defaultMargin : 6,
              8,
              (index == 6) ? defaultMargin : 6,
              8,
            ),
            child: Container(
              width: 250,
              height: 210,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(spreadRadius: 1, color: Colors.black12)
                  ],),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8), topRight: Radius.circular(8),),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 12, 8, 6),
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}