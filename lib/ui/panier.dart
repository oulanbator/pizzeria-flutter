import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/cart_list.dart';
import 'package:pizzeria/ui/cart_total.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:intl/intl.dart';

class Panier extends StatelessWidget {
  const Panier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Panier')
      ),
      body: Column(
        children: const [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CartList(),
            ),
          ),
          CartTotal()
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}