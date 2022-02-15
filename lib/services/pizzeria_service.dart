import 'dart:convert';
import 'package:pizzeria/models/boisson.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:http/http.dart' as http;


class PizzeriaService {
  // API path (running on a local springboot instance)
  // static const String uri = 'http://192.168.1.72:8080/api/pizzas';

  // API path (running on private VPS on internet)
  static const String uri = 'http://139.177.181.28:9999/api/';

  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];

    try {

      final response = await http.get(Uri.parse(uri + "pizzas"));

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

  Future<List<Boisson>> fetchBoissons() async {
    List<Boisson> list = [];

    try {

      final response = await http.get(Uri.parse(uri + "boissons"));

      if (response.statusCode == 200) {
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for (final value in json) {
          list.add(Boisson.fromJson(value));
        }
      } else {
        throw Exception('Impossible de récupérer les boissons');
      }
    } catch (e) {
      rethrow;
    }

    return list;
  }
}