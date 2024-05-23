import 'package:eau/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RechargePage extends StatelessWidget {
  const RechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharger votre compteur"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.couleur_bleu,
          ),
        ),
      ),
      body: Container(
        width: width,
        padding: Marge.margeMiniPage,
        child: FormBuilder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Entrez le montant de votre recharge",
                  textAlign: TextAlign.left,
                  style: TextDesign.text_bleu.copyWith(fontSize: 15)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width - 60,
                child: Container(
                    decoration: ContainerDecoration.button_principale
                        .copyWith(color: Palette.couleur_bleu.withAlpha(100)),
                    child: FormBuilderTextField(
                      name: "montant",
                      decoration: TextFieldDecoration.champ,
                      cursorColor: Palette.couleur_blanche,
                      style: TextDesign.text_blanc,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: width - 60,
                      padding: Marge.margeBoutons,
                      decoration: ContainerDecoration.button_secondaire,
                      child: const Text(
                        "Recharger",
                        style: TextDesign.text_blanc,
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
