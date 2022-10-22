import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/article_list_bloc/article_list_bloc.dart';
import 'package:headline_news/presentation/widgets/loading_article_card.dart';
import 'package:headline_news/presentation/widgets/loading_article_list.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:headline_news/presentation/pages/article_category_page.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({ Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ArticleTopHeadlineListBloc>(context, listen: false)
            .add(ArticleListEvent()),);
    Future.microtask(() =>
        Provider.of<ArticleHeadlineBusinessListBloc>(context, listen: false)
            .add(ArticleListEvent()),);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        children: [
          Column(
            children: [ 
              _listTopHeadlineArticles(),
              const SizedBox(height:8),
              _listCategory(),
              const SizedBox(height: 8),
              _listHeadlineBusinessArticles()
            ],
          )
        ],
      ),
    );
  }

  Widget _listTopHeadlineArticles() {
    return Container(
      height: 230,
      width: double.infinity,
      color: kWhiteColor,
      child: BlocBuilder<ArticleTopHeadlineListBloc, ArticleListState>(
        builder: (context, state) {
          if(state is ArticleListLoading) {
            return const LoadingArticleCard();       
          } else if(state is ArticleListLoaded) {
            return ListView.builder(
              key: const Key('headline_news_item'),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                var article = state.articles[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    (article == state.articles.first) ? 24 : 6,
                    8,
                    (article == state.articles.last) ? 24 : 6,
                    8,
                  ),
                  child: TopHeadlineArticleCard(article: article),
                );      
              }, 
            );
          } else if(state is ArticleListEmpty) {
            return const Center(child: Text('Empty Article'));
          } else if (state is ArticleListError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _listCategory() {
    return Container(
      height: 120,
      width: double.infinity,
      color: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right:24),
        child: ListView(
          key: const Key('article_category'),
          scrollDirection: Axis.horizontal,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'sport'),
                ),
              ),
              child: const CategoryCard('Sport', 'assets/sports.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'business'),
                ),
              ),
              child: const CategoryCard('Business', 'assets/business.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'health'),
                ),
              ),
              child: const CategoryCard('Health', 'assets/health.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'science'),
                ),
              ),
              child: const CategoryCard('Science', 'assets/science.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'technology'),
                ),
              ),
              child: const CategoryCard('Technology', 'assets/technology.png'),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleCategoryPage(category: 'entertainment'),
                ),
              ),
              child: const CategoryCard('Entertainment', 'assets/entertainment.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listHeadlineBusinessArticles() {
    return BlocBuilder<ArticleHeadlineBusinessListBloc, ArticleListState>(
      builder: (context, state) {
        if(state is ArticleListLoading) {
          return Container(            
            color: kWhiteColor,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
            child: const LoadingArticleList(),
          );        
        } else if(state is ArticleListLoaded) {
          return Container(
            color: kWhiteColor,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
               child: ListView.builder(
                  key: const Key('headline_business_item'),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    var article = state.articles[index];
                    return ArticleList(article: article);              
                  }, 
                ),
          );
        } else if(state is ArticleListEmpty) {
          return const Center(child: Text('Empty Article'));
        } else if (state is ArticleListError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}