import 'package:eau/design.dart';
import 'package:eau/pages/authentification.dart';
import 'package:flutter/material.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      height: tailleEcran.height,
      width: tailleEcran.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/image.jpg"), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const Authentification(
                        indexPageActuel: 0,
                      )),
                ));
              },
              child: Container(
                  padding: Marge.margeBoutons,
                  width: tailleEcran.width,
                  decoration: ContainerDecoration.button_principale,
                  child: const Text(
                    "Se connecter",
                    style: TextDesign.text_bleu,
                    textAlign: TextAlign.center,
                  ))),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => Authentification(
                        indexPageActuel: 2,
                      )),
                ));
              },
              child: Container(
                  padding: Marge.margeBoutons,
                  width: tailleEcran.width,
                  decoration: ContainerDecoration.button_secondaire,
                  child: const Text(
                    "S'inscrire",
                    style: TextDesign.text_blanc,
                    textAlign: TextAlign.center,
                  ))),
        ],
      ),
    );
  }
}
