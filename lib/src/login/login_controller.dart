import 'package:flutter/material.dart';
import 'package:flutter_notes/src/home/home_page.dart';
import 'package:flutter_notes/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final Function onUpdate;
  var userModel = UserModel(
    name: '',
    phone: '',
    email: '',
    cpf: '',
    birthday: '',
    password: '',
  );
  var isLoading = false;
  LoginController({required this.onUpdate});

  Future<void> getUser(context, String email, String password) async {
    isLoading = true;
    onUpdate();
    await Future.delayed(Duration(seconds: 2));
    final instance = await SharedPreferences.getInstance();
    final response = instance.getString("user");
    if (response != null) {
      final user = UserModel.fromJson(response);
      if (email == user.email && password == user.password) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        alert(context, 'Senha Incorreta');
      }
      isLoading = false;
      onUpdate();
    }
  }

  alert(context, text) {
    showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
