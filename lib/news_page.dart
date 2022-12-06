import 'dart:convert';

import 'package:fashion/db/categories.dart';
import 'package:fashion/db/news.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final String title;

  const NewsPage({
    required this.title,
    Key? key
  }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map newsItem = {};
  String categoryTitle = '';

  @override
  void initState() {

    News.get().then((value) {
      setState(() {
        List news = json.decode(value);
        newsItem = news.firstWhere((item) => item['title'] == widget.title);

        Categories.get().then((value) {
          setState(() {
            List categories = json.decode(value);

            Map categoryItem = categories.firstWhere(
                  (item) => item['id'] == newsItem['category'],
              orElse: () => {'title': 'Нет'},
            );

            categoryTitle = categoryItem['title'];
          });
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
      child: newsItem.isNotEmpty ? 
        Column(
          children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                      newsItem['title'],
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 22,)
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(categoryTitle,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                    ),
                    Text(newsItem['date'],
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                    )
  
                  ],
                ),
              ),
  
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(newsItem['imageUrl'], fit: BoxFit.cover),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    newsItem['body'],
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18, height: 1.5)
                ),
              )
            ],
          ) : Text('Загрузка'),
      )
    );
  }
}
