part of 'widgets.dart';

class ArticleList extends StatelessWidget {
  final Article article;

  const ArticleList({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        
      },
      child: Container(
          margin: EdgeInsets.only(
            bottom: 16,
            left: 20,
            right: 20,
          ),
          child: Row(children: [
            Container(
              height: 80,
              width: 110,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(
                    article.urlToImage!
                  ), 
                  fit: BoxFit.cover
                )
              )
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title,
                    style: blackTextStyle.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(article.author ?? "",
                      style: greyTextStyle.copyWith(fontSize: 12))
                ],
              ),
            )
          ]),
        ),
    );
  }
}
