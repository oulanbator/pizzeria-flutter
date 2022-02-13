import 'package:pizzeria/models/option_item.dart';
import 'package:pizzeria/models/produit.dart';

class Boisson implements Produit {
  final int id;
  final String title;
  final int sucre;
  final String image;
  final double price;

  Boisson(this.id, this.title, this.sucre, this.image, this.price);

  Boisson.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        sucre = json['sucre'],
        image = json['image'],
        price = json['price'];

  // Sélection de l'utilisateur
  bool glacons = false;
  int quantite = 0;

  // Les options possibles
  static final List<OptionItem> optionQuantite = [
    OptionItem(0, "33cl"),
    OptionItem(1, "50cl", supplement: 1),
    OptionItem(2, "100cl", supplement: 2)
  ];

  double get total {
    double total = price;
    total += optionQuantite[quantite].supplement;
    glacons ? total += 0.5 : null;
    return total;
  }
}