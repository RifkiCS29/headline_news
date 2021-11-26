import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/string_extensions.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/article_category_bloc/article_category_bloc.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ArticleCategoryPage extends StatefulWidget {
  final String category;
  const ArticleCategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<ArticleCategoryPage> createState() => _ArticleCategoryPageState();
}

class _ArticleCategoryPageState extends State<ArticleCategoryPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ArticleCategoryBloc>(context, listen: false)
            .add(FetchArticleCategory(widget.category)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0.0,
        title: Text(
          widget.category.toCapitalized(), 
          style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold)
        ),
      ),
      body: BlocBuilder<ArticleCategoryBloc, ArticleCategoryState>(
        builder: (context, state) {       
        print(widget.category);
         if(state is ArticleCategoryLoading) {
            return Center(child: loadingIndicator);        
          } else if(state is ArticleCategoryHasData) {
            return Padding(
              padding: const EdgeInsets.only(top:8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  var article = state.articles[index];
                  return ArticleList(article: article);              
                } 
              ),
            );
          } else if(state is ArticleCategoryEmpty) {
            return Center(child: Text(state.message));
          } else if (state is ArticleCategoryError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text(''));
          }
        }
      )
    );
  }
}