import 'package:flutter/material.dart';
import 'package:pizzeria/ui/cart_list.dart';
import 'package:pizzeria/ui/cart_total.dart';
import 'package:pizzeria/ui/paiement.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';

class Panier extends StatelessWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Panier')
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CartList(),
            ),
          ),
          const CartTotal(),
          Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Paiement()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: const Size.fromHeight(50)
                  ),
                  child: const Text("REGLER MA COMMANDE")
              )
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }
}