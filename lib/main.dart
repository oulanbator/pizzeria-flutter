import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/menu.dart';
import 'package:pizzeria/ui/boisson_list.dart';
import 'package:pizzeria/ui/panier.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/profil.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => Cart(),
        child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzéria',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(title: 'Notre pizzéria'),
        '/commande': (context) => PizzaList(),
        '/panier': (context) => Panier(),
        '/profil': (context) => Profil(),
        '/boissons': (context) => BoissonList(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  // Constructor
  MyHomePage({required this.title, Key? key})
      : super(key: key);

  final List<Menu> _menus = [
    Menu(1, 'Entrées', 'entree.png', Colors.lightGreen),
    Menu(2, 'Pizzas', 'pizza.png', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.png', Colors.brown),
    Menu(4, 'Boissons', 'boisson.png', Colors.lightBlue)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title),
      body: Center(
        child: ListView.builder(
          itemCount: _menus.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              String page = "/";
              switch(_menus[index].type) {
                case 2: // Pizza
                  page = "/commande";
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => PizzaList())
                  // );
                  break;
                case 4: // Boisson
                  page = "/boissons";
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => PizzaList())
                  // );
                  break;
              }
              Navigator.pushNamed(context, page);
            },
            child: _buildRow(_menus[index]),
          ),
          itemExtent: 180
        )
      ),
      bottomNavigationBar: BottomNavigationBarWidget(0),
    );
  }

  _buildRow(Menu menu) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: menu.color,
          borderRadius: const BorderRadius.all(Radius.circular(20.0))
      ),
      margin: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Expanded(
              child: Image.asset(
                'assets/images/menus/${menu.image}',
                fit: BoxFit.fitWidth,
              )
          ),
          Container(
            height: 50,
            child: Center(
              child: Text(
                menu.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 28
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


