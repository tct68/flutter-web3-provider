import 'dart:convert';

import 'package:flutter/foundation.dart';

class JsonUtil {
  static String? encodeObj(Object value) {
    return json.encode(value);
  }

  static dynamic getObj<T>(String? source) {
    if (source == null || source.isEmpty) return null;
    try {
      return json.decode(source);
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getObjFuture<T>(String? source) async {
    if (source == null || source.isEmpty) return null;
    try {
      return await compute(getObj, source);
    } catch (e) {
      return null;
    }
  }

  static List<T>? getObjList<T>(String source) {
    if (source.isEmpty) return null;
    try {
      List? list = json.decode(source);

      return list?.map((value) {
        return value;
      }).toList() as List<T>?;
    } catch (e) {
      print('JsonUtil convert error, Exception：${e.toString()}');
    }

    return null;
  }
}
