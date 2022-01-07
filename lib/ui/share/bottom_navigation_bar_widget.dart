import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/badge_widget.dart';
import 'package:provider/src/provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int indexSelected;

  const BottomNavigationBarWidget(this.indexSelected, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var _totalItems = cart.totalItems();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: indexSelected,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Accueil"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: "Commande"
        ),
        BottomNavigationBarItem(
            icon: _totalItems == 0
              ? Icon(Icons.shopping_cart_outlined)
              : BadgeWidget(
                  child: Icon(Icons.shopping_cart),
                  value: _totalItems,
                  top: 0,
                  right: 0,
                ),
            label: "Panier"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil"
        ),
      ],
      onTap: (index) {
        String page = "/";
        switch (index) {
          case 1 :
            page = "/commande";
            break;
          case 2 :
            page = "/panier";
            break;
          case 3 :
            page = "/profil";
            break;
        }
        Navigator.pushNamed(context, page);
      },
    );
  }
}
