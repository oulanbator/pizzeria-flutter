import 'package:flutter/material.dart';
import 'package:pizzeria/models/boisson.dart';
import 'package:pizzeria/models/option_item.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

class BoissonDetails extends StatefulWidget {

  final Boisson _boisson;

  const BoissonDetails(this._boisson, {Key? key}) : super(key: key);

  @override
  _BoissonDetailsState createState() => _BoissonDetailsState();
}

class _BoissonDetailsState extends State<BoissonDetails> {
  @override
  Widget build(BuildContext context) {

    MaterialColor sliderColor;
    if (widget._boisson.sucre <= 1.5) {
      sliderColor = Colors.green;
    } else if (widget._boisson.sucre > 1.5 && widget._boisson.sucre < 3) {
      sliderColor = Colors.orange;
    } else {
      sliderColor = Colors.red;
    }

    return Scaffold(
        appBar: AppBarWidget(widget._boisson.title),
        body: ListView(
          padding: const EdgeInsets.all(4.0),
          children: [
            Text(
              widget._boisson.title,
              style: PizzeriaStyle.pageTitleTextStyle,
            ),
            Image.asset(
              'assets/images/boissons/${widget._boisson.image}',
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                'Teneur en sucre',
                style: PizzeriaStyle.headerTextStyle,
              ),
            ),

            SliderTheme(
              data: SliderThemeData(thumbColor: sliderColor),
              child: Slider(
                value: widget._boisson.sucre.toDouble(),
                onChanged: (double d) => {},
                min: 0,
                max: 10,
                activeColor: sliderColor,
                inactiveColor: sliderColor.shade100,
                label: widget._boisson.sucre.toString(),
              ),
            ),
            Text(
              'Extras',
              style: PizzeriaStyle.headerTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Glaçons"),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 12.0),
                  child: SizedBox(
                    width: 30.0,
                    child: SwitchListTile(
                      onChanged: (bool value) {
                        setState(() => widget._boisson.glacons = value);
                      },
                      value: widget._boisson.glacons,
                    ),
                  )
                ),

              ],
            ),
            Text('Quantité', style: PizzeriaStyle.headerTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<int>(
                  groupValue: widget._boisson.quantite,
                  value: 0,
                  onChanged: (value) => setState(() {
                    widget._boisson.quantite = 0;
                  }),
                ),
                Text("33cl"),
                Radio<int>(
                  groupValue: widget._boisson.quantite,
                  value: 1,
                  onChanged: (value) => setState(() {
                    widget._boisson.quantite = 1;
                  }),
                ),
                Text("50cl"),
                Radio<int>(
                  groupValue: widget._boisson.quantite,
                  value: 2,
                  onChanged: (value) => setState(() {
                    widget._boisson.quantite = 2;
                  }),
                ),
                Text("100cl"),

              ],
            ),
            TotalWidget(widget._boisson.total),
            BuyButtonWidget(widget._boisson)
          ],
        )
    );
  }
}
