import 'package:e_commerce_model/helpers/validators.dart';
import 'package:e_commerce_model/models/user.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha seu Nome completo';
                    }
                    return null;
                  },
                  onSaved: (name) {
                    user.name = name;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (email) {
                    user.email = email;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) {
                    user.password = pass;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Repita a Senha'),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) {
                    user.confirmPassword = pass;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        if (user.password != user.confirmPassword) {
                          scaffolKey.currentState.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Senhas não coincidem!',
                                overflow: TextOverflow.fade,
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        //TODO MANDAR O USER PARA O USERMANAGER
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    child: const Text(
                      'Cria Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
