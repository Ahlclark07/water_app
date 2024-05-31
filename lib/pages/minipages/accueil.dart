import 'dart:convert';
import 'dart:developer';

import 'package:async_builder/async_builder.dart';
import 'package:eau/components/display_on_tab.dart';
import 'package:eau/components/toggleswitch.dart';
import 'package:eau/design.dart';
import 'package:eau/utils/laravel_backend.dart';
import 'package:eau/utils/mqtt_helper.dart';
import 'package:flutter/material.dart';

class AccueilMain extends StatefulWidget {
  const AccueilMain({super.key});

  @override
  State<AccueilMain> createState() => _AccueilMainState();
}

class _AccueilMainState extends State<AccueilMain> {
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect();
    mqttHandler.publishDemandeMessage();
  }

  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      width: tailleEcran.width,
      padding: Marge.margePage,
      child: ValueListenableBuilder(
          valueListenable: mqttHandler.data,
          builder: (context, value, child) {
            final objetRecu = jsonDecode(value == "" ? "{}" : value);
            inspect(objetRecu);
            return AsyncBuilder(
                future: LaravelBackend().recupererAbonnement(),
                waiting: (context) => const CircularProgressIndicator(),
                builder: (context, response) {
                  final abonnement = response![1];
                  return Column(
                    children: [
                      DisplayOnTab(
                          titre: "MON ABONNEMENT",
                          value: (abonnement!["titre"] ?? "")),
                      DisplayOnTab(
                          titre: "VOLUME TOTAL",
                          value: "${abonnement["total"]}"),
                      DisplayOnTab(
                          titre: "VOLUME RESTANT",
                          value:
                              "${abonnement["total"] - abonnement["consommation"]}"),
                      DisplayOnTab(
                          titre: "VOLUME UTILISE",
                          value: "${abonnement["consommation"]}"),
                      Container(
                        color: Palette.couleur_bleu.withAlpha(70),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Etat du compteur"),
                            ToggleSwitch(mqttHandler)
                          ],
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}


// Affiche la page d'accueil avec mqtt, bof obselète
// ValueListenableBuilder(
//           valueListenable: mqttHandler.data,
//           builder: (context, value, child) {
//             if (value.contains("'")) value = value.replaceAll("'", "\"");
//             final objet = value != "" ? jsonDecode(value) : {};
//             final abonnement = objet["abonnement"] ?? "____";
//             final total = objet["total"] ?? "____";
//             final restant = objet["restant"] ?? "____";
//             final utilise = objet['utilise'] ?? "____";
//             return Column(
//               children: [
//                 DisplayOnTab(titre: "MON ABONNEMENT", value: abonnement),
//                 DisplayOnTab(titre: "VOLUME TOTAL", value: total),
//                 DisplayOnTab(titre: "VOLUME RESTANT", value: restant),
//                 DisplayOnTab(titre: "VOLUME UTILISE", value: utilise),
//                 Container(
//                   color: Palette.couleur_bleu.withAlpha(70),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Etat du compteur"),
//                       ToggleSwitch(mqttHandler)
//                     ],
//                   ),
//                 )
//               ],
//             );
//           }),