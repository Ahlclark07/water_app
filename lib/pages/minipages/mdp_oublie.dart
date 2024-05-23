import 'package:eau/design.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class PageMDPOublie extends StatelessWidget {
  const PageMDPOublie({super.key});
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
            "Mot de passe oublié",
            style: TextDesign.titre,
          ),
          const Text(
            "Entrez l'adresse email associée à votre compte afin de recevoir un lien pour la création d'un nouveau mot de passe.",
            style: TextDesign.text_blanc,
          ),
          FormBuilder(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: ContainerDecoration.button_principale,
                  child: FormBuilderTextField(
                    name: "email",
                    decoration: TextFieldDecoration.champ.copyWith(
                        labelText: "Adresse e-mail",
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Container(
                        width: tailleEcran.width - 60,
                        padding: Marge.margeBoutons,
                        decoration: ContainerDecoration.button_principale,
                        child: const Text(
                          "Envoyer l'email",
                          style: TextDesign.text_bleu,
                          textAlign: TextAlign.center,
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
