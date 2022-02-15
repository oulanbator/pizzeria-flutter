import 'package:flutter/cupertino.dart';

class UserProfile extends ChangeNotifier{
  String nom;
  String email;
  String description;
  String image;

  UserProfile([
    this.nom = "Victor",
    this.email = "victor.matheron@gmail.com",
    this.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    this.image = "assets/images/profil/vm.jpg"
  ]);

  setNom(String nom) {
    this.nom = nom;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}