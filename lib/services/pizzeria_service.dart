import 'dart:convert';
import 'dart:io';

import 'package:pizzeria/models/pizza.dart';
import 'package:http/http.dart' as http;


class PizzeriaService {
  static const String uri = 'http://192.168.1.72:8080/api/pizzas';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {

      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for (final value in json) {
          list.add(Pizza.fromJson(value));
        }
      } else {
        throw Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      rethrow;
    }

    return list;
  }
}