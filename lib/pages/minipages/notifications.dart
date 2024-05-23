import 'package:async_builder/async_builder.dart';
import 'package:eau/design.dart';
import 'package:eau/utils/laravel_backend.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      width: tailleEcran.width,
      padding: Marge.margeMiniPage,
      child: AsyncBuilder(
          waiting: (context) => const CircularProgressIndicator(),
          future: LaravelBackend().recupererNotifications(),
          builder: (context, notifications) {
            if (notifications![0] == LaravelBackend.echec) {
              return const Text("Une erreur s'est produite");
            }
            if (notifications[1]!.isEmpty) {
              return const Text("Pas de notificationspour le moment");
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List<NotificationItem>.generate(
                    notifications[1].length,
                    ((index) => NotificationItem(
                          titre: notifications[1][index]["message"],
                          temps: notifications[1][index]["date"],
                          payement:
                              notifications[1][index]["type"] == "recharge",
                        ))),
              ],
            );
          }),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String temps;

  final String titre;
  final bool payement;

  const NotificationItem(
      {super.key,
      required this.titre,
      required this.temps,
      required this.payement});

  @override
  Widget build(BuildContext context) {
    final tailleEcran = MediaQuery.of(context).size;
    return Container(
      width: tailleEcran.width - 60,
      height: 95,
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: .2))),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Palette.couleur_bleu,
            child: Icon(
              payement ? Icons.attach_money : Icons.water,
              size: 30,
              color: Palette.couleur_blanche,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Flex(direction: Axis.vertical, children: [
                    Text(
                      maxLines: 5,
                      titre,
                      style: TextDesign.text_bleu.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ]),
                ),
                Text(
                  "Il y a $temps",
                  style: TextDesign.text_blanc.copyWith(color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
