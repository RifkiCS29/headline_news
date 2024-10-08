import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/string_extensions.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/article_category_bloc/article_category_bloc.dart';
import 'package:headline_news/presentation/widgets/loading_article_list.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:headline_news/injection.dart' as di;

class ArticleCategoryPage extends StatelessWidget {
  final String category;
  const ArticleCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: kPrimaryColor),
        title: Text(
          category.toCapitalized(),
          style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      ),
      body: BlocProvider(
        create: (_) => di.locator<ArticleCategoryBloc>()
          ..add(
            FetchArticleCategory(category),
          ),
        child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.microtask(
                  () => BlocProvider.of<ArticleCategoryBloc>(context)
                      .add(FetchArticleCategory(category)),
                );
              },
              child: BlocBuilder<ArticleCategoryBloc, ArticleCategoryState>(
                builder: (context, state) {
                  if (state is ArticleCategoryLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: LoadingArticleList(),
                    );
                  } else if (state is ArticleCategoryHasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.articles.length,
                        itemBuilder: (context, index) {
                          var article = state.articles[index];
                          return ArticleList(article: article);
                        },
                      ),
                    );
                  } else if (state is ArticleCategoryEmpty) {
                    return Center(child: Text(state.message));
                  } else if (state is ArticleCategoryError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text(''));
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
