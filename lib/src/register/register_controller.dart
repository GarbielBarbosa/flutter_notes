import 'package:flutter/material.dart';
import 'package:flutter_notes/src/login/login_page.dart';
import 'package:flutter_notes/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController {
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
  RegisterController({required this.onUpdate});

  Future<void> saveUser(user, context) async {
    isLoading = true;
    onUpdate();
    await Future.delayed(Duration(seconds: 1));
    try {
      userModel = user;
      final instance = await SharedPreferences.getInstance();
      final response = await instance.setString("user", userModel.toJson());
      if (response) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        alert(context, "Não foi possível realizar essa operação");
      }
      isLoading = false;
      onUpdate();
    } catch (e) {
      isLoading = false;
      print(e);
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
