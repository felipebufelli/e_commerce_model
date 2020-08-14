import 'package:e_commerce_model/helpers/validators.dart';
import 'package:e_commerce_model/models/user.dart';
import 'package:e_commerce_model/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email)) {
                          return "E-mail inválido!";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passController,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      enabled: !userManager.loading,
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6) {
                          return 'Senha inválida!';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: const Text('Esqueci minha senha'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44.0,
                      child: RaisedButton(
                        onPressed: userManager.loading ? null : () {
                          if (formKey.currentState.validate()) {
                            userManager.signIn(
                              user: User(
                                  email: emailController.text,
                                  password: passController.text),
                              onFail: (error) {
                                scaffolKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Falha ao entrar: $error',
                                      overflow: TextOverflow.fade,
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSuccess: () {
                                //TODO: LEMBRAR DE FECHAR TELA DE LOGIN
                              },
                            );
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        child: userManager.loading ? 
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                          :
                          const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18),
                          ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
