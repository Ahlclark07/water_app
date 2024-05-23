import 'package:eau/design.dart';
import 'package:flutter/material.dart';

class DisplayOnTab extends StatelessWidget {
  final String titre;

  final String value;

  const DisplayOnTab({super.key, required this.titre, required this.value});

  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            width: tailleEcran.width - 100,
            padding: const EdgeInsets.all(15),
            color: Palette.couleur_bleu,
            child: Text(
              titre,
              style: TextDesign.text_blanc,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: tailleEcran.width - 100,
            color: Palette.couleur_or,
            child: Text(
              value,
              style: TextDesign.text_bleu,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
