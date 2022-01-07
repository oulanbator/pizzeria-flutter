import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/src/provider.dart';
import 'package:intl/intl.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: cart.totalItems(),
      itemBuilder: (context, index) {
        return _buildItem(context, cart.getCartItem(index));
      }
    );
  }

  /// Builder for one item. Based on a Card widget.
  _buildItem(BuildContext context, CartItem item) {
    return Card(
        shape: _itemCardShape(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/pizzas/${item.pizza.image}',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            _buildItemDetails(context, item)
          ],
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

  /// Widget with the main blocs of an Item
  _buildItemDetails(BuildContext context, CartItem item) {
    return Expanded(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: _itemTitle(item),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: _itemQuantitySelection(context, item),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: _itemTotal(item),
            ),
          ]
      ),
    );
  }

  /// The item title
  _itemTitle(CartItem item) {
    return Text(
        item.pizza.title,
        style: PizzeriaStyle.headerTextStyle
    );
  }

  /// The row with selection of quantity
  _itemQuantitySelection(BuildContext context, CartItem item) {
    var format = NumberFormat("###.00 €");
    String totalAffiche = format.format(item.pizza.total);

    return Row(
      children: [
        Expanded(
            child: Text(
                totalAffiche,
                style: PizzeriaStyle.itemPriceTextStyle)
        ),
        Expanded(child: _itemQuantity(context, item)),
      ],
    );
  }

  /// The Command area for changing the quantity
  _itemQuantity(BuildContext context, CartItem item) {
    var cart = context.watch<Cart>();
    return Row(
      children: [
        IconButton(
            onPressed: () {
              cart.removeOne(item);
            },
            icon: const Icon(Icons.remove_circle_outline_rounded)
        ),
        Text(
          item.quantity.toString(),
          style: PizzeriaStyle.subHeaderTextStyle,
        ),
        IconButton(
            onPressed: () {
              cart.addOne(item);
            },
            icon: const Icon(Icons.add_circle_outline_rounded)
        ),
      ],
    );
  }

  /// Item total relative to quantity
  _itemTotal(CartItem item) {
    var format = NumberFormat("###.00 €");
    String totalAffiche = format.format(item.pizza.total * item.quantity);

    return item.quantity > 0 ?
    Text(
        'Sous-Total : ' + totalAffiche,
        style: PizzeriaStyle.priceSubTotalTextStyle
    ) :
    Text(
        'Sous-Total : 0€',
        style: PizzeriaStyle.priceSubTotalTextStyle
    );
  }

}
