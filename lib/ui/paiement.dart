import 'package:flutter/material.dart';
import 'package:pizzeria/ui/cart_total.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class Paiement extends StatefulWidget {
  String selectedLivraison = "Sur place";
  String selectedPaiement = "Carte de crédit";
  Paiement({Key? key}) : super(key: key);

  @override
  _PaiementState createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget("Régler ma commande"),
      body: Column(
        children: [
          Expanded(child: _buildPaiementPage()),
          const CartTotal(),
          Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: const Size.fromHeight(50)
                  ),
                  child: const Text("VALIDER")
              )
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(2),
    );
  }

  _buildPaiementPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            'Livraison',
            style: PizzeriaStyle.pageTitleTextStyle,
          ),
        ),
        _buildLivraisonCard(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            'Moyen de paiement',
            style: PizzeriaStyle.pageTitleTextStyle,
          ),
        ),
        _buildPaiementCard(),
      ],
    );
  }

  _buildLivraisonCard() {
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
          RadioListTile(
            value: "Sur place",
            secondary: const Icon(Icons.restaurant),
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: widget.selectedLivraison,
            title: const Text("Sur place"),
            onChanged: (value) {
              setState(() {
                widget.selectedLivraison = value.toString();
              });
          }),
          RadioListTile(
            value: "A emporter",
            secondary: const Icon(Icons.takeout_dining),
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: widget.selectedLivraison,
            title: const Text("A emporter"),
            onChanged: (value) {
              setState(() {
                widget.selectedLivraison = value.toString();
              });
          }),
          RadioListTile(
            value: "A domicile",
            secondary: const Icon(Icons.home),
            controlAffinity: ListTileControlAffinity.trailing,
            groupValue: widget.selectedLivraison,
            title: const Text("A domicile"),
            onChanged: (value) {
              setState(() {
                widget.selectedLivraison = value.toString();
              });
          })
        ],
      ),
    );
  }

  _buildPaiementCard() {
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
          RadioListTile(
              value: "Carte de crédit",
              secondary: const Icon(Icons.payment),
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: widget.selectedPaiement,
              title: const Text("Carte de crédit"),
              onChanged: (value) {
                setState(() {
                  widget.selectedPaiement = value.toString();
                });
              }),
          RadioListTile(
              value: "Paypal",
              secondary: const Icon(Icons.payments),
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: widget.selectedPaiement,
              title: const Text("Paypal"),
              onChanged: (value) {
                setState(() {
                  widget.selectedPaiement = value.toString();
                });
              }),
          RadioListTile(
              value: "Sur place",
              secondary: const Icon(Icons.euro),
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: widget.selectedPaiement,
              title: const Text("Sur place"),
              onChanged: (value) {
                setState(() {
                  widget.selectedPaiement = value.toString();
                });
              })
        ],
      ),
    );
  }
}
