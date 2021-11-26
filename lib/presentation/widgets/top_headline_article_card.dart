part of 'widgets.dart';

class TopHeadlineArticleCard extends StatelessWidget {
  final Article article;

  const TopHeadlineArticleCard({required this.article});

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
        width: 250,
        height: 210,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(spreadRadius: 1, color: Colors.black12)
            ]),
        child: Column(
          children: [
            Container(
              height: 140,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                          'assets/errorimage.jpg',
                          fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(8, 12, 8, 6),
              width: 200,
              child: Text(
                article.title,
                style: blackTextStyle.copyWith(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
