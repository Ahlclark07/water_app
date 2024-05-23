import 'package:eau/design.dart';

import 'package:eau/pages/minipages/accueil.dart';
import 'package:eau/pages/minipages/notifications.dart';
import 'package:eau/pages/minipages/profil.dart';
import 'package:eau/utils/laravel_backend.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int indexPageActuel = 0;
  final pages = [const AccueilMain(), const NotificationPage(), const Profil()];
  final pageTitle = ["Accueil", "Notfications", "Profils"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 70,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                child: Text("Menu"),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("Nous contacter"),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pushNamed("/recharge"),
              leading: const Icon(Icons.monetization_on),
              title: const Text("Recharger votre compte"),
            ),
            ListTile(
              onTap: () async {
                final response = await LaravelBackend().deconnexion();
                if (response[0] == LaravelBackend.success) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(response[1])));
                  Navigator.of(context).popAndPushNamed("/authentification");
                }
              },
              leading: Icon(Icons.person_off),
              title: Text("Se déconnecter"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(pageTitle[indexPageActuel]),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return pages[indexPageActuel];
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Palette.couleur_bleu,
        currentIndex: indexPageActuel,
        onTap: (value) {
          setState(() {
            indexPageActuel = value;
          });
        },
        elevation: 20,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profils"),
        ],
      ),
    );
  }
}
