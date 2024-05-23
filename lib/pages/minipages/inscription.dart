import 'package:eau/design.dart';
import 'package:eau/utils/laravel_backend.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PageInscription extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mdpController = TextEditingController();
  final TextEditingController mdp2Controller = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  PageInscription({super.key});
  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return FormBuilder(
      key: _formKey,
      child: Container(
        padding: Marge.margeMiniPage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Créer un nouveau compte",
              style: TextDesign.titre,
            ),
            FormBuilder(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: ((tailleEcran.width - 60) / 2) - 10,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: ContainerDecoration.button_principale,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: nomController,
                            validator: FormBuilderValidators.required(
                                errorText: "Champ requis"),
                            name: "nom",
                            decoration: TextFieldDecoration.champ.copyWith(
                                labelText: "Nom",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ((tailleEcran.width - 60) / 2) - 10,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: ContainerDecoration.button_principale,
                          child: FormBuilderTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            name: "prenom",
                            controller: prenomController,
                            validator: FormBuilderValidators.required(
                                errorText: "Champ requis"),
                            decoration: TextFieldDecoration.champ.copyWith(
                                labelText: "Prénom",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: ContainerDecoration.button_principale,
                    child: FormBuilderTextField(
                      name: "tel",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      controller: telController,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Champ requis"),
                        FormBuilderValidators.integer(
                            errorText: "Entrez un vrai numero"),
                        FormBuilderValidators.minLength(8,
                            errorText: "Entrez un vrai numero")
                      ]),
                      decoration: TextFieldDecoration.champ.copyWith(
                          labelText: "Téléphone",
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: ContainerDecoration.button_principale,
                    child: FormBuilderTextField(
                      name: "email",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.email(),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: TextFieldDecoration.champ.copyWith(
                          labelText: "Adresse e-mail",
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: ContainerDecoration.button_principale,
                    child: FormBuilderTextField(
                      name: "compteur_id",
                      controller: idController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.minLength(7,
                          errorText: "Entrez une valeur valide"),
                      decoration: TextFieldDecoration.champ.copyWith(
                          labelText: "ID du compteur",
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: ContainerDecoration.button_principale,
                    child: FormBuilderTextField(
                      obscureText: true,
                      name: "mdp",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.minLength(7),
                      controller: mdpController,
                      decoration: TextFieldDecoration.champ.copyWith(
                          labelText: "Mot de passe",
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: ContainerDecoration.button_principale,
                    child: FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: mdp2Controller,
                      validator: FormBuilderValidators.equal(mdpController.text,
                          errorText: "Les mots de passes ne correspondent pas"),
                      name: "mdpc",
                      decoration: TextFieldDecoration.champ.copyWith(
                          labelText: "Confirmez votre mot de passe",
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                  const Text(
                    "En cliquant sur s'inscrire vous acceptez les termes de nos conditions d'utilisations.",
                    style: TextDesign.text_blanc,
                  ),
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.isValid) {
                          final response = await LaravelBackend().inscription(
                              nom: nomController.text,
                              prenoms: prenomController.text,
                              tel: telController.text,
                              email: emailController.text,
                              idCompteur: idController.text,
                              mdp: mdpController.text);

                          if (response[0] == LaravelBackend.success) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Bienvenu ${response[1]}")));
                            Navigator.of(context).popAndPushNamed("/main");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Erreur : ${response[0]} : ${response[1]}")));
                          }
                        }
                      },
                      child: Container(
                          width: tailleEcran.width - 60,
                          padding: Marge.margeBoutons,
                          decoration: ContainerDecoration.button_principale,
                          child: const Text(
                            "S'inscrire",
                            style: TextDesign.text_bleu,
                            textAlign: TextAlign.center,
                          ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
