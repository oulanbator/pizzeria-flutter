import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/user_profile.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/src/provider.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    var format = NumberFormat("###.00 €");
    double totalTtc = 0;

    for (int i = 0 ; i < cart.totalItems() ; i++) {
      var item = cart.getCartItem(i);
      var itemTotal = (item.produit.price * item.quantity);
      totalTtc += itemTotal;
    }

    String totalHtAffiche = format.format(totalTtc * 80 / 100);
    String totalTvaAffiche = format.format(totalTtc * 20 / 100);
    String totalTtcAffiche = format.format(totalTtc);

    return Card(
        shape: _itemCardShape(),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: _buildTotalTable(totalHtAffiche, totalTvaAffiche, totalTtcAffiche)
        )
    );
  }

  /// Shape of the Card item
  _itemCardShape() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
          top: Radius.circular(2.0),
        )
    );
  }

  _buildTotalTable(String totalHtAffiche, String totalTvaAffiche, String totalTtcAffiche) {
    return Table(
      children: [
        TableRow(
            children: [
              Container(),
              TableCell(
                  child: Text("TOTAL HT", style: PizzeriaStyle.priceSubTotalTextStyle)
              ),
              TableCell(
                  child: Text(totalHtAffiche, style: PizzeriaStyle.priceSubTotalTextStyle, textAlign: TextAlign.end)
              )
            ]
        ),
        TableRow(
            children: [
              Container(),
              TableCell(
                  child: Text("TVA (20%)", style: PizzeriaStyle.priceSubTotalTextStyle)
              ),
              TableCell(
                  child: Text(totalTvaAffiche, style: PizzeriaStyle.priceSubTotalTextStyle, textAlign: TextAlign.end)
              )
            ]
        ),
        TableRow(
            children: [
              Container(),
              TableCell(
                  child: Text("TOTAL TTC", style: PizzeriaStyle.priceTotalTextStyle)
              ),
              TableCell(
                  child: Text(totalTtcAffiche, style: PizzeriaStyle.priceTotalTextStyle, textAlign: TextAlign.end)
              )
            ]
        ),
      ],
    );
  }

  _buildSubmitButton() {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            child: const Text('VALIDER LE PANIER'),
            onPressed: () {print('VALIDER LE PANIER');}
        )
    );
  }
}
