import 'package:flutter/cupertino.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/produit.dart';

class CartItem {
  final Produit produit;
  int quantity;

  CartItem(this.produit, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Produit produit) {
    // Recherche du produit
    int index = _findCartItemIndex(produit.id);
    if (index == -1) {
      // Ajout
      _items.add(CartItem(produit));
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  void removeProduct(Produit produit) {
    // Recherche du produit
    int index = _findCartItemIndex(produit.id);
    if (index != -1) {
      // Suppression
      _items.removeAt(index);
    }
    notifyListeners();
  }

  int _findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.produit.id == id);
  }

  void removeOne(CartItem item) {
    int index = _findCartItemIndex(item.produit.id);
    int quantity = getCartItem(index).quantity;
    if (quantity > 0) {
      getCartItem(index).quantity -= 1;
    }
    if (getCartItem(index).quantity == 0) {
      removeProduct(item.produit);
    }
    notifyListeners();
  }

  void addOne(CartItem item) {
    int index = _findCartItemIndex(item.produit.id);
    getCartItem(index).quantity += 1;
    notifyListeners();
  }

}