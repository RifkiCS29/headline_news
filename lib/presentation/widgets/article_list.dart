part of 'widgets.dart';

class ArticleList extends StatelessWidget {
  final Article article;

  const ArticleList({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(article: article),
          ),
        ),
      },
      child: Container(
          margin: EdgeInsets.only(
            bottom: 16,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(children: [
            Container(
              width: 110,
              height: 80,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  width: 110,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                          'assets/errorimage.jpg',
                          fit: BoxFit.cover),
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
