import 'package:flutter/cupertino.dart';
import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    // Recherche du produit
    int index = _findCartItemIndex(pizza.id);
    if (index == -1) {
      // Ajout
      _items.add(CartItem(pizza));
    } else {
      // Incrémente la quantité
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  void removeProduct(Pizza pizza) {
    // Recherche du produit
    int index = _findCartItemIndex(pizza.id);
    if (index != -1) {
      // Suppression
      _items.removeAt(index);
    }
    notifyListeners();
  }

  int _findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }

  void removeOne(CartItem item) {
    int index = _findCartItemIndex(item.pizza.id);
    int quantity = getCartItem(index).quantity;
    if (quantity > 0) {
      getCartItem(index).quantity -= 1;
    }
    if (getCartItem(index).quantity == 0) {
      removeProduct(item.pizza);
    }
    notifyListeners();
  }

  void addOne(CartItem item) {
    int index = _findCartItemIndex(item.pizza.id);
    getCartItem(index).quantity += 1;
    notifyListeners();
  }

}