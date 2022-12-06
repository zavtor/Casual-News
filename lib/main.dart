import 'dart:convert';
import 'package:fashion/db/categories.dart';
import 'package:fashion/db/news.dart';
import 'package:fashion/info.dart';
import 'package:fashion/news_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
      const MaterialApp(
        title: 'Casual News',
        home: MyApp(),
      ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List categories = [];
  late List news = [];
  List<Widget> posts = [];
  String? currentCategoryId;
  String title = 'Всі новини';


  @override
  void initState() {
    Categories.get().then((value) {
      setState(() {
        categories = json.decode(value);
        _setPosts();
      });
    });
    News.get().then((value) {
      setState(() {
        news = json.decode(value);
        _setPosts();
      });
    });

    super.initState();
  }

  _setPosts() {
    posts = [];
    List newsList;
    if (currentCategoryId == null) {
      newsList = news;
    } else {
      newsList = news.where((item) => item['category'] == currentCategoryId).toList();
    }

    for (var i = 0; i < newsList.length; i++) {
      Map categoryItem = categories.firstWhere(
              (item) => item['id'] == newsList[i]['category'],
              orElse: () => {'title': 'Нет'},
      );

      posts.add(
          NewsCard(
              id: i,
              title: newsList[i]['title'],
              imageUrl: newsList[i]['imageUrl'],
              // category: categories.getById(newsList[i]['category'])['title'],
              category: categoryItem['title'],
              date: newsList[i]['date']
          )
      );
    }

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoPage()),
              );
            },
            icon: const Icon(Icons.info_outline_rounded))
          ],
        ),
        drawer: Drawer(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Dior.jpg'),
                          fit: BoxFit.cover
                      ),
                    ),
                    child: Text('Категорії', style: TextStyle(color: Colors.white,fontSize: 20),)
                );
              }

              return ListTile(
                title: Text(categories[index]['title'] as String),
                onTap: () {
                  setState(() {
                    currentCategoryId = categories[index]['id'];
                    title = categories[index]['title'];
                    _setPosts();
                  });
                  Navigator.of(context).pop();
                }
              );
            },
            // children: categoryWidgets,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: posts,
            ),
          ),
        )
      ),
    );
  }
}


class NewsCard extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String category;
  final String date;

  const NewsCard({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.date,
    super.key
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NewsPage(title: widget.title)
            )
          );
        },
        splashColor: Colors.blue.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title.length > 64 ? '${widget.title.substring(0, 64)}...' : widget.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.category,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                            ),
                          ),
                          Text(widget.date,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey
                            ),
                          )
                        ]),
                    ],
                  ),
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(widget.imageUrl, width: 120, height: 120, fit: BoxFit.cover),
              )
            ],
          ),
        )
      ),
    );
  }
}


