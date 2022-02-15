import 'package:flutter/material.dart';
import 'package:pizzeria/models/user_profile.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:provider/src/provider.dart';

class ProfilEdit extends StatefulWidget {
  ProfilEdit({Key? key}) : super(key: key);

  @override
  _ProfilEditState createState() => _ProfilEditState();
}

class _ProfilEditState extends State<ProfilEdit> {
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProfile>();
    return Scaffold(
      appBar: AppBarWidget("Modifier le profil"),
      body: Form(
          key: _formKey,
          child: _buildForm(user)
      )
    );
  }

  _buildForm(UserProfile user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField("Nom", true, 1),
        _buildTextFormField("Email", true, 1),
        _buildTextFormField("Description", false, 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState!.validate()) {
                user.setNom(nomController.text);
                user.setEmail(emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profil mis à jour !")),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }

  _buildTextFormField(String fieldName, bool obligatoire, int lines) {
    TextEditingController controller = _getTextController(fieldName);
    controller.text = _getPlaceHolder(fieldName);
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(fieldName),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        maxLines: lines,
        validator: (String? value) {
          if (!obligatoire) return null;
          if (value == null || value.isEmpty) {
            return 'Champ obligatoire';
          }
          return null;
        },
      );
  }

  TextEditingController _getTextController(String fieldName) {
    if (fieldName == "Nom") {
      return nomController;
    } else if (fieldName == "Email") {
      return emailController;
    } else if (fieldName == "Description") {
      return descriptionController;
    } else {
      return TextEditingController();
    }
  }

  _getPlaceHolder(String fieldName) {
    var user = context.watch<UserProfile>();
    if (fieldName == "Nom") {
      return user.nom;
    } else if (fieldName == "Email") {
      return user.email;
    } else if (fieldName == "Description") {
      return user.description;
    } else {
      return "";
    }
  }
}
