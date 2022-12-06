library news;
import 'package:flutter/services.dart';

class News {
  List<dynamic> items = [];

  static Future get() async {
   return await rootBundle.loadString('assets/news.json');
  }

  // getByCategoryId(var id) {
  //   if (id == null) {
  //     return items;
  //   }
  //
  //   return items.where((item) => item['category'] == id).toList();
  // }
  //
  // Map getByNewsId(int id) {
  //   return items[id];
  // }
}