import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:provider/src/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({ Key? key }) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (query) {
                context.read<SearchArticleBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                  hintText: 'Search...',
                  labelStyle: TextStyle(
                    color: kPrimaryColor,
                  ),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(24)
                  ),
                  contentPadding: EdgeInsets.all(12)
                ),
                textInputAction: TextInputAction.search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Search Result',
              style: blackTextStyle,
            ),
          ),
          Flexible(
            child: BlocBuilder<SearchArticleBloc, SearchArticleState>(
              builder: (context, state) {
                if (state is SearchArticleLoading) {
                  return Center(
                    child: loadingIndicator
                  );
                } else if (state is SearchArticleHasData) {
                  final result = state.searchResult;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, index) {
                      final article = state.searchResult[index];
                      return ArticleList(article: article);
                    },
                    itemCount: result.length,
                  );
                } else if (state is SearchArticleEmpty) {
                  return Center(
                    child: Text(state.message, style: blackTextStyle),
                  );
                } else if (state is SearchArticleError) {
                  return Center(
                    child: Text(state.message, style: blackTextStyle),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}