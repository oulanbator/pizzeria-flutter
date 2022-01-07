import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:provider/provider.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;

  const BuyButtonWidget(this._pizza, {Key? key}) : super(key: key);

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
              print('Commander une pizza');
              _cart.addProduct(_pizza);
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
