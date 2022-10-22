import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headline_news/common/config.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/presentation/bloc/search_article_bloc/search_article_bloc.dart';
import 'package:headline_news/presentation/widgets/initial.dart';
import 'package:headline_news/presentation/widgets/loading_article_list.dart';
import 'package:headline_news/presentation/widgets/nodata.dart';
import 'package:headline_news/presentation/widgets/error.dart';
import 'package:headline_news/presentation/widgets/widgets.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

String _query = '';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              key: const Key('edtSearch'),
              onChanged: (query) {
                _query = query;
                context.read<SearchArticleBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                  hintText: 'Search...',
                  labelStyle: TextStyle(
                    color: kPrimaryColor,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(24),),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kGreyColor),
                      borderRadius: BorderRadius.circular(24),),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(24),),
                  contentPadding: const EdgeInsets.all(12),),
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
                  return const Center(
                    child: Initial(message: 'Search the News'),
                  );
                } else if (state is SearchArticleLoading) {
                  return const LoadingArticleList();
                } else if (state is SearchArticleHasData) {
                  currentPage = state.currentPage;
                  final result = state.searchResult;
                  totalPage = (state.totalResult / pageSize).ceil();
                  return LazyLoadScrollView(
                    onEndOfPage: () {
                      if ((currentPage < 5) && (currentPage < totalPage)) {
                        context
                            .read<SearchArticleBloc>()
                            .add(OnNextPage(_query, currentPage));
                      }
                    },
                    scrollOffset: 150,
                    child: ListView.builder(
                      key: const Key('search_item'),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        final article = result[index];
                        return ArticleList(article: article);
                      },
                      itemCount: result.length,
                    ),
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
                  return Center(
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
    super.dispose();
  }
}
