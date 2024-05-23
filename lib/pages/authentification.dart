import 'package:eau/design.dart';
import 'package:eau/pages/minipages/connexion.dart';
import 'package:eau/pages/minipages/inscription.dart';
import 'package:eau/pages/minipages/mdp_oublie.dart';
import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  final int indexPageActuel;

  const Authentification({super.key, required this.indexPageActuel});

  @override
  State<Authentification> createState() =>
      // ignore: no_logic_in_create_state
      _AuthentificationState(indexPageActuel: indexPageActuel);
}

class _AuthentificationState extends State<Authentification> {
  int indexPageActuel;
  _AuthentificationState({required this.indexPageActuel});
  @override
  Widget build(BuildContext context) {
    updateState(index) {
      setState(() {
        indexPageActuel = index;
      });
    }

    final List<Widget> pages = [
      PageConnexion(
        updateState: updateState,
      ),
      const PageMDPOublie(),
      PageInscription()
    ];
    return Scaffold(
      backgroundColor: Palette.couleur_bleu,
      appBar: AppBar(
        backgroundColor: Palette.couleur_bleu,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed("/");
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.couleur_blanche,
          ),
        ),
      ),
      body: SingleChildScrollView(child: pages[indexPageActuel]),
    );
  }
}
