import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

foo() async {
  Map all = {};
  for (var a in List.generate(66, (i) => i + 1)) {
    Response res = await Dio().get('https://api.getbible.net/v2/kjv/$a.json');
    dynamic data = res.data;
    List<int> temp = [];
    for (var b in data['chapters']) {
      temp.add(b['verses'].length);
    }
    all.putIfAbsent(data['name'], () => temp);
    print(data['name']);
  }

  log(jsonEncode(all));
}
