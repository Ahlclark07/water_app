import 'dart:developer';

import 'package:eau/design.dart';
import 'package:eau/utils/laravel_backend.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PageConnexion extends StatelessWidget {
  final Function updateState;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController mdpController = TextEditingController();
  PageConnexion({super.key, required this.updateState});
  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      padding: Marge.margeMiniPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Connectez vous à votre compte",
            style: TextDesign.text_blanc,
          ),
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: ContainerDecoration.button_principale,
                  child: FormBuilderTextField(
                    controller: idController,
                    name: "compteur_id",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.minLength(7,
                        errorText: "Entrez un id valide"),
                    decoration: TextFieldDecoration.champ.copyWith(
                        labelText: "ID du compteur",
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: ContainerDecoration.button_principale,
                  child: FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: mdpController,
                    name: "mot_de_passe",
                    validator: FormBuilderValidators.minLength(7,
                        errorText: "Entrez un mot de passe valide"),
                    decoration: TextFieldDecoration.champ.copyWith(
                        labelText: "Mot de passe",
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      updateState(1);
                    },
                    child: const Text(
                      "Mot de passe oublié ?",
                      style: TextDesign.text_blanc,
                      textAlign: TextAlign.right,
                    )),
                TextButton(
                    onPressed: null,
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.isValid) {
                          final response = await LaravelBackend().connexion(
                              idCompteur: idController.text,
                              mdp: mdpController.text);
                          inspect(response);
                          if (response[0] == LaravelBackend.success) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Bienvenu ${response[1]}")));
                            Navigator.of(context).popAndPushNamed("/main");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Erreur : ${response[0]} : ${response[1]}")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Veuillez remplir tous les champs")));
                        }
                      },
                      child: Container(
                          width: tailleEcran.width - 60,
                          padding: Marge.margeBoutons,
                          decoration: ContainerDecoration.button_principale,
                          child: const Text(
                            "Se connecter",
                            style: TextDesign.text_bleu,
                            textAlign: TextAlign.center,
                          )),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
