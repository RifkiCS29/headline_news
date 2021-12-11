import 'dart:async';
import 'package:headline_news/common/encrypt.dart';
import 'package:headline_news/data/models/article_table.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblBookmarkArticle = 'bookmark_article';
  static const String _tblCacheArticle = 'cache_article';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/newsapp.db';

    var db = await openDatabase(
      databasePath, 
      version: 1, 
      onCreate: _onCreate,
      password: encrypt('HeadlineNews')
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblBookmarkArticle (
        url TEXT PRIMARY KEY,
        author TEXT,
        title TEXT,
        description TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCacheArticle (
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        category TEXT,
        idCacheArticle INTEGER PRIMARY KEY AUTOINCREMENT
      );
    ''');
  }

  Future<void> insertCacheTransactionArticles(
    List<ArticleTable> articles, String category
  ) async {
    final db = await database;
    db!.transaction((txn) async {
      for(final article in articles) {
        final articleJson = article.toJson();
        articleJson['category'] = category;
        txn.insert(_tblCacheArticle, articleJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheArticles(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCacheArticle,
      where: 'category = ?',
      whereArgs: [category],
    );

    return results;
  }

  Future<int> clearCacheArticles(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCacheArticle,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertBookmarkArticle(ArticleTable article) async {
    final db = await database;
    return await db!.insert(_tblBookmarkArticle, article.toJson());
  }

  Future<int> removeBookmarkArticle(ArticleTable article) async {
    final db = await database;
    return await db!.delete(
      _tblBookmarkArticle,
      where: 'url = ?',
      whereArgs: [article.url],
    );
  }

  Future<Map<String, dynamic>?> getArticleByUrl(String url) async {
    final db = await database;
    final results = await db!.query(
      _tblBookmarkArticle,
      where: 'url = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarkArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> results = 
      await db!.query(
        _tblBookmarkArticle,
        orderBy: 'publishedAt DESC'
      );

    return results;
  }
}
