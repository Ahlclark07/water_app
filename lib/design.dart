import 'package:flutter/material.dart';

class Palette {
  static const couleur_blanche = Colors.white;
  static const couleur_or = Colors.yellow;
  static const couleur_bleu = Color(0xFF1C5081);
}

class Marge {
  static const margeBoutons = EdgeInsets.symmetric(vertical: 10);
  static const margeMiniPage = EdgeInsets.all(30);
  static const margePage = EdgeInsets.symmetric(vertical: 30, horizontal: 50);
}

class TextDesign {
  static const titre = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 30,
      color: Palette.couleur_blanche);

  static const text_blanc = TextStyle(color: Palette.couleur_blanche);
  static const text_bleu = TextStyle(color: Palette.couleur_bleu);
}

class ContainerDecoration {
  static const button_principale = BoxDecoration(
      color: Palette.couleur_blanche,
      borderRadius: BorderRadius.all(Radius.circular(50)));
  static const button_secondaire = BoxDecoration(
      color: Palette.couleur_bleu,
      borderRadius: BorderRadius.all(Radius.circular(50)));
}

class TextFieldDecoration {
  static const champ = InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: EdgeInsets.symmetric(horizontal: 20));
}
