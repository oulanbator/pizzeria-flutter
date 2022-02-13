import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/src/provider.dart';

class PizzaList extends StatefulWidget {
  // final Cart _cart;
  const PizzaList({Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;
  final PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    _pizzas = _service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
      appBar: const AppBarWidget('Nos Pizzas'),
      body: FutureBuilder<List<Pizza>>(
          future: _pizzas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListView(cart, snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Impossible de récupérer les données : ${snapshot.error}',
                  style: PizzeriaStyle.errorTextStyle,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(1),
    );
  }

  _buildListView(Cart cart, List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(cart, pizzas[index]);
      },
    );
  }

  Widget _buildRow(Cart cart, Pizza pizza) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
            top: Radius.circular(2.0),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PizzaDetails(pizza, cart)));
            },
            child: _buildPizzaDetails(pizza),
          ),
          BuyButtonWidget(pizza)
        ],
      ),
    );
  }

  _buildPizzaDetails(Pizza pizza) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: const Icon(Icons.local_pizza),
        ),
        Image.asset(
          'assets/images/pizzas/${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        )
      ],
    );
  }
}



