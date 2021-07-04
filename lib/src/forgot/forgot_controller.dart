import 'package:flutter/material.dart';
import 'package:flutter_notes/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotController {
  final Function onUpdate;
  var isLoading = false;
  ForgotController({required this.onUpdate});

  Future<void> getUser(context) async {
    isLoading = true;
    onUpdate();
    await Future.delayed(Duration(seconds: 1));
    final instance = await SharedPreferences.getInstance();
    final response = instance.getString("user");
    if (response != null) {
      final user = UserModel.fromJson(response);
      alertCompost(
          context,
          'Email enviado com sucesso',
          'Brincadeira, ainda não estamos prontos para isso',
          'Seu email é: ${user.email}" e sua senha é ${user.password}"');
      isLoading = false;
      onUpdate();
    } else {
      alert(context, 'Não há usuarios cadastrados');
      isLoading = false;
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
              padding: const EdgeInsets.all(12.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
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

  alertCompost(context, title, subtitle, text) {
    showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, bottom: 12, right: 5, top: 5),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
