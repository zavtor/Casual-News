library categories;

import 'package:flutter/services.dart';

class Categories {
  List<Map<String, String>> items = [];

  static Future get() async {
    return await rootBundle.loadString('assets/categories.json');
  }


  // getById(var id) {
  //   return items.firstWhere((item) => item['id'] == id);
  // }

}