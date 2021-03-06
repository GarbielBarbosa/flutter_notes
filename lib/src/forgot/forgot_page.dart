import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notes/src/forgot/forgot_controller.dart';
import 'package:flutter_notes/src/shared/validators/text_validator.dart';
import 'package:flutter_notes/src/shared/widgets/custom_text_field.dart';
import 'package:flutter_notes/src/shared/widgets/shared_widgets.dart';

class ForgotPage extends StatefulWidget {
  ForgotPage({Key? key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController _emailController = TextEditingController();
  late ForgotController controller = ForgotController(onUpdate: () {
    setState(() {});
  });
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 29, 44, 1),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(32, 29, 44, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: .0),
                    Image.asset(
                      "assets/forgot.png",
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Esqueceu sua senha ?",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      "Digite o seu email no campo abaixo para realizar o reset.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    CustomTextField(
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.deepPurple,
                      ),
                      validator: (value) => Validators().email(value ?? ''),
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: controller.isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  controller.getUser(context);
                                }
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Enviar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
