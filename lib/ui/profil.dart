import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/user_profile.dart';
import 'package:pizzeria/ui/profil_edit.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profil extends StatelessWidget {
  // final UserProfile user = UserProfile();

  Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProfile>();
    return Scaffold(
      appBar: const AppBarWidget("Mon profil"),
      body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 30.0),
            _buildHeader(user.image, context),
            const SizedBox(height: 24.0),
            _buildSubHeader(user.nom, user.email),
            const SizedBox(height: 24.0),
            Center(child: _buildFollowButton()),
            const SizedBox(height: 48.0),
            _buildAbout(user.description),
          ],
        ),
      bottomNavigationBar: const BottomNavigationBarWidget(3),
    );
  }

  _buildHeader(String imagePath, BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _buildImage(imagePath),
          Positioned(
            child: _buildEditButton(Colors.blue, context),
            bottom: 10,
            right: 10,
          )
        ],
      )
    );
  }

  _buildImage(String imagePath) {
    return ClipOval(child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: Image.asset(imagePath).image,
        fit: BoxFit.cover,
        width: 180,
        height: 180,
        child: InkWell(onTap: _doNothing),
      ),
    ));
  }

  _buildEditButton(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilEdit()))
      },
      child: _buildCircle(
          color: Colors.white,
          all: 3,
          child: _buildCircle(
              color: color,
              all: 8,
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              )
          )
      ),
    );
  }

  _buildCircle({
    required Color color,
    required double all,
    required Widget child
  }) {
    return ClipOval(child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child
    ));
  }

  _buildSubHeader(String name, String email) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: 4.0),
        Text(
          email,
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.grey),
        )
      ],
    );
  }

  _buildFollowButton() {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12)
        ),
        onPressed: _launchUrl,
        label: const Text("Check my instagram"),
        icon: _instagramIcon()
    );
  }

  void _launchUrl() async {
    var url = 'https://www.instagram.com/tor.mth/';
    if (!await launch(url, universalLinksOnly: true)) throw 'Could not launch $url';
  }

  _instagramIcon() {
    return IconButton(
      onPressed: () {},
      icon: const FaIcon(FontAwesomeIcons.instagram),
      iconSize: 30.0,
    );
  }

  Widget _buildAbout(String about) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About me",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Text(
            about,
            style: const TextStyle(fontSize: 16, height: 1.4),

          )
        ],
      ),
    );
  }

  _doNothing() {}
}


