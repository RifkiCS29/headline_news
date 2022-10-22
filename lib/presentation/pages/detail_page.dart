import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/presentation/bloc/article_detail_bloc/article_detail_bloc.dart';
import 'package:headline_news/presentation/pages/article_webview_page.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  final Article article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ArticleDetailBloc>(context, listen: false)
          .add(LoadBookmarkStatus(widget.article.url));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ArticleDetailBloc, ArticleDetailState>(
        listener: (context, state) async {
          if (state.bookmarkMessage ==
                  ArticleDetailBloc.bookmarkAddSuccessMessage ||
              state.bookmarkMessage ==
                  ArticleDetailBloc.bookmarkRemoveSuccessMessage) {
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  backgroundColor: state.bookmarkMessage ==
                  ArticleDetailBloc.bookmarkAddSuccessMessage ? kGreenColor : kRedColor,
                  content: Text(state.bookmarkMessage),
                ),);
          } else {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.bookmarkMessage),
                );
              },
            );
          }
        },
        listenWhen: (previousState, currentState) =>
            previousState.bookmarkMessage != currentState.bookmarkMessage &&
            currentState.bookmarkMessage != '',
        builder: (context, state) { 
          return Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.bottom),
                        );
                      },
                      blendMode: BlendMode.darken,
                      child: CachedNetworkImage(
                        imageUrl: widget.article.urlToImage ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover,),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/errorimage.jpg',
                            fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [                            
                            GestureDetector(
                              onTap: () => {
                                if (!state.isAddedToBookmark) {
                                    Provider.of<ArticleDetailBloc>(
                                          context,
                                          listen: false,)
                                        .add(AddToBookmark(widget.article))
                                  } else {
                                    Provider.of<ArticleDetailBloc>(
                                          context,
                                          listen: false,)
                                        .add(RemoveFromBookmark(widget.article))
                                  }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),),
                                child: Center(
                                  child: Icon(
                                    state.isAddedToBookmark 
                                      ? Icons.bookmark 
                                      : Icons.bookmark_border,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Share.share(
                                  "${widget.article.title}\nDetail: ${widget.article.url}",),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),),
                                child: Center(
                                  child: Icon(
                                    Icons.share,
                                    color: kPrimaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        bottom: 50,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy kk:mm').format(
                                widget.article.publishedAt ?? DateTime.now(),),
                            style: whiteTextStyle.copyWith(fontSize: 14),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.article.title ?? 'No Title',
                            style: whiteTextStyle.copyWith(
                                fontSize: 18, fontWeight: semiBold,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.article.author ?? 'No Author',
                            style: whiteTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.48,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                      20,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.article.description ?? '',
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.article.content ?? '',
                        style: greyTextStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        key: const Key('button_read_more'),
                        title: 'Read More',
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleWebviewPage(url: widget.article.url),
                            ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
