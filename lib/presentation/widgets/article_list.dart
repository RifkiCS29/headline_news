part of 'widgets.dart';

class ArticleList extends StatelessWidget {
  final Article article;

  const ArticleList({Key? key, required this.article}) : super(key: key);

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
          key: const Key('article_list_item'),
          margin: EdgeInsets.only(
            bottom: 16,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Row(children: [
            SizedBox(
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
                      image: imageProvider, fit: BoxFit.cover,),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                          'assets/errorimage.jpg',
                          fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: blackTextStyle.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(article.author ?? 'No Author',
                      style: greyTextStyle.copyWith(fontSize: 12),)
                ],
              ),
            )
          ],),
        ),
    );
  }
}
