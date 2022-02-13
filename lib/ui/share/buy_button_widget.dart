import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/models/produit.dart';
import 'package:provider/provider.dart';

class BuyButtonWidget extends StatelessWidget {
  // final Pizza _pizza;
  final Produit _produit;

  const BuyButtonWidget(this._produit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtention de l'objet cart depuis le provider
    // Nous n'écoutons pas les notifications émises
    var _cart = Provider.of<Cart>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            onPressed: () {
              _cart.addProduct(_produit);
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade800)
            ),
            child: Row(
              children: const [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text('Commander')
              ],
            )
        )
      ],
    );
  }
}
