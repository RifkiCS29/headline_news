import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/config.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:headline_news/presentation/widgets/initial.dart';
import 'package:headline_news/presentation/widgets/nodata.dart';
import 'package:headline_news/presentation/widgets/error.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:provider/src/provider.dart';

String _query = '';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>  
  with AutomaticKeepAliveClientMixin {

  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int totalPage = 0;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (query) {
                _query = query;
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
                if (state is SearchArticleInitial) {
                  return Center(
                    child: Initial(message: 'Search the News'),
                  );
                } else if (state is SearchArticleLoading) {
                  return Center(
                    child: loadingIndicator
                  );
                } else if (state is SearchArticleHasData) {
                  currentPage = state.currentPage;
                  final result = state.searchResult;
                  return ListView.builder(
                    controller: _scrollController
                      ..addListener(() {
                        if (_scrollController.offset ==
                                _scrollController.position.maxScrollExtent) {
                            print('currentPageIndside: $currentPage');
                            totalPage = (result.length / pageSize).ceil();
                            print('totalPage: $totalPage');
                            context
                                .read<SearchArticleBloc>()
                                .add(OnNextPage(_query, currentPage));
                        }
                    }),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, index) {
                      final article = result[index];
                      return ArticleList(article: article);
                    },
                    itemCount: result.length,
                  );
                } else if (state is SearchArticleEmpty) {
                  return Center(
                    child: NoData(message: state.message),
                  );
                } else if (state is SearchArticleError) {
                  return Center(
                    child: Error(message: state.message),
                  );
                } else {
                  return Container(
                    child: Text(state.runtimeType.toString()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}