import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notes/src/register/register_controller.dart';
import 'package:flutter_notes/src/shared/models/user_model.dart';
import 'package:flutter_notes/src/shared/validators/text_validator.dart';
import 'package:flutter_notes/src/shared/widgets/custom_text_field.dart';
import 'package:flutter_notes/src/shared/widgets/shared_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterController controller = RegisterController(onUpdate: () {
    setState(() {});
  });

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _bornDateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  FocusNode _cpfFocusNode = FocusNode();

  TextEditingController _passwordController = TextEditingController();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bornDateController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _cpfFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(32, 29, 44, 1),
        elevation: 0.0,
      ),
      backgroundColor: Color.fromRGBO(32, 29, 44, 1),
      body: Padding(
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
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "Nome",
                  controller: _nameController,
                  validator: (value) => Validators().validateName(value ?? ''),
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "Telefone",
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    TextInputMask(mask: ['(99) 9999-9999', '(99) 99999-9999'])
                  ],
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    TextInputMask(mask: ['99/99/9999'])
                  ],
                  labelText: "Data de Nascimento",
                  controller: _bornDateController,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validators().validateDate(value ?? ''),
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "E-mail",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "CPF",
                  controller: _cpfController,
                  focusNode: _cpfFocusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    TextInputMask(mask: ['999.999.999-99'])
                  ],
                  validator: (cpf) => Validators().cpfValidator(cpf ?? ''),
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  labelText: "Senha",
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: passwordVisible,
                  suffixIcon: VisibleWidget(
                    visible: passwordVisible,
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8.0),
                CustomTextField(
                  labelText: "Confirmar Senha",
                  controller: _confirmPasswordController,
                  validator: (value) => Validators().validatePassword(
                    value ?? '',
                    _passwordController.value.text,
                  ),
                  obscureText: confirmPasswordVisible,
                  suffixIcon: VisibleWidget(
                    visible: confirmPasswordVisible,
                    onPressed: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 80.0),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: SafeArea(
                        bottom: true,
                        child: controller.isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    final UserModel user = new UserModel(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      email: _emailController.text,
                                      cpf: _cpfController.text,
                                      birthday: _bornDateController.text,
                                      password: _passwordController.text,
                                    );
                                    controller.saveUser(user, context);
                                  } else {
                                    if (Validators().cpfValidator(
                                            _cpfController.value.text) !=
                                        null) {
                                      _cpfFocusNode.requestFocus();
                                    }
                                  }
                                },
                                child: Text(
                                  "Criar conta",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
