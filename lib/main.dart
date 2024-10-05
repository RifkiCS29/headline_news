import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news/common/theme.dart';
import 'package:headline_news/common/utils.dart';
import 'package:headline_news/presentation/pages/article_category_page.dart';
import 'package:headline_news/presentation/pages/detail_page.dart';
import 'package:headline_news/presentation/pages/splash_page.dart';
import 'package:headline_news/common/http_ssl_pinning.dart';
import 'package:headline_news/domain/entities/article.dart';
import 'package:headline_news/injection.dart' as di;
import 'package:headline_news/presentation/pages/article_webview_page.dart';
import 'package:headline_news/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Headline News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kWhiteColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: kColorScheme.copyWith(secondary: kPrimaryColor),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
      ),
      home: const SplashPage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/main-page':
            return CupertinoPageRoute(builder: (_) => const MainPage());
          case 'article-category-page':
            final category = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => ArticleCategoryPage(category: category),
              settings: settings,
            );
          case 'article-detail-page':
            final article = settings.arguments as Article;
            return MaterialPageRoute(
              builder: (_) => DetailPage(article: article),
              settings: settings,
            );
          case 'article-webview-page':
            final url = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => ArticleWebviewPage(url: url),
              settings: settings,
            );
          default:
            return MaterialPageRoute(
              builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
