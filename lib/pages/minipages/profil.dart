import 'package:async_builder/async_builder.dart';
import 'package:d_chart/d_chart.dart';
import 'package:eau/design.dart';
import 'package:flutter/material.dart';
import 'package:eau/utils/laravel_backend.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    final Map user = LaravelBackend().user;
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      width: tailleEcran.width,
      margin: Marge.margeMiniPage,
      child: Column(
        children: [
          const Icon(
            Icons.person,
            size: 70,
            color: Palette.couleur_bleu,
          ),
          const SizedBox(
            height: 20,
          ),
          DisplayLineInfo(
              titre: "Nom et prénoms",
              valeur: "${user["nom"]} ${user["prenoms"]}"),
          DisplayLineInfo(titre: "Email", valeur: "${user["email"]}"),
          DisplayLineInfo(titre: "Téléphone", valeur: "${user["tel"]}"),
          DisplayLineInfo(
              titre: "ID du compteur", valeur: "${user["id_compteur"]}"),
          AsyncBuilder(
              initial: const [],
              waiting: (context) => const CircularProgressIndicator(),
              future: LaravelBackend().recupererConsommation(),
              builder: (context, consommations) {
                if (consommations![0] == LaravelBackend.success) {
                  if (consommations[1].isEmpty) {
                    return const Text("Pas de consommations pour le moment");
                  } else {
                    return Container(
                      height: 300,
                      width: tailleEcran.width - 100,
                      child: DChartBarO(
                        groupList: [
                          OrdinalGroup(
                              id: "1",
                              color: Palette.couleur_bleu,
                              data: List<OrdinalData>.generate(
                                  consommations[1].length,
                                  (index) => OrdinalData(
                                      domain: consommations[1][index]["date"],
                                      measure: consommations[1][index]
                                          ["consommation"])))
                        ],
                      ),
                    );
                  }
                } else {
                  return const Text("Une erreur s'est produite");
                }
              })
        ],
      ),
    );
  }
}

class DisplayLineInfo extends StatelessWidget {
  final String titre;

  final String valeur;

  const DisplayLineInfo({super.key, required this.titre, required this.valeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titre,
            style: TextDesign.text_bleu,
          ),
          Text(
            valeur,
            style: TextDesign.text_bleu,
          )
        ],
      ),
    );
  }
}
