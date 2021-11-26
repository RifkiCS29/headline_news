import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/utils.dart';
import 'package:headline_news/presentation/bloc/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({ Key? key }) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BookmarkArticleBloc>(context, listen: false)
            .add(BookmarkArticleEvent()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<BookmarkArticleBloc>(context, listen: false)
      .add(BookmarkArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocBuilder<BookmarkArticleBloc, BookmarkArticleState>(
        builder: (context, state) {       
         if(state is BookmarkArticleLoading) {
            return Center(child: loadingIndicator);        
          } else if(state is BookmarkArticleHasData) {
            return Padding(
              padding: const EdgeInsets.only(top:8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.bookmarkArticle.length,
                itemBuilder: (context, index) {
                  var article = state.bookmarkArticle[index];
                  return ArticleList(article: article);              
                } 
              ),
            );
          } else if(state is BookmarkArticleEmpty) {
            return Center(child: Text(state.message));
          } else if (state is BookmarkArticleError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        }
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}