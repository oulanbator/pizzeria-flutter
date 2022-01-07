import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget("Mon profil"),
      body: Container(),
      bottomNavigationBar: BottomNavigationBarWidget(3),
    );
  }
}
