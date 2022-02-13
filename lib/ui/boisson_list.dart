import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/boisson.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
import 'package:pizzeria/ui/boisson_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/src/provider.dart';

class BoissonList extends StatefulWidget {
  const BoissonList({Key? key}) : super(key: key);

  @override
  _BoissonListState createState() => _BoissonListState();
}

class _BoissonListState extends State<BoissonList> {

  late Future<List<Boisson>> _boissons;
  final PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    _boissons = _service.fetchBoissons();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
      appBar: const AppBarWidget('Nos Boissons'),
      body: FutureBuilder<List<Boisson>>(
        future: _boissons,
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

  _buildListView(Cart cart, List<Boisson> boissons) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: boissons.length,
      itemBuilder: (context, index) {
        return _buildRow(cart, boissons[index]);
      },
    );
  }

  Widget _buildRow(Cart cart, Boisson boisson) {
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
                  MaterialPageRoute(builder: (context) => BoissonDetails(boisson)));
            },
            child: _buildBoissonDetails(boisson),
          ),
          BuyButtonWidget(boisson)
        ],
      ),
    );
  }

  _buildBoissonDetails(Boisson boisson) {
    MaterialColor sliderColor;
    if (boisson.sucre <= 1.5) {
      sliderColor = Colors.green;
    } else if (boisson.sucre > 1.5 && boisson.sucre < 3) {
      sliderColor = Colors.orange;
    } else {
      sliderColor = Colors.red;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Image.asset(
            'assets/images/boissons/${boisson.image}',
            height: 100,
            fit: BoxFit.fitHeight,
          ),
        ),
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(boisson.title, style: PizzeriaStyle.headerTextStyle))
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text("Teneur en sucre"),
                  )
                ]
            ),
            SizedBox(
              height: 50,
              child: SliderTheme(
                data: SliderThemeData(thumbColor: sliderColor),
                child: Slider(
                  value: boisson.sucre.toDouble(),
                  onChanged: (double d) => {},
                  min: 0,
                  max: 10,
                  activeColor: sliderColor,
                  inactiveColor: sliderColor.shade100,
                  label: boisson.sucre.toString(),
                )
              ),
            ),
          ],
        )),
      ],
    );
  }
}
