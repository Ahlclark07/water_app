# Avant de démarrer le projet, il faut :

## - Démarrer le serveur mqtt.
  Ce serveur permettra de faire la communication entre le système sous arduino + esp et l'application mobile. Entre autre je cite :

  - Envoyer une demande de mise à jour des données de l'abonnement actuel au système electronique sur **le topic "client\_{idDuCient}/demandeUpdate"** que ce dernier écoute. Ainsi dès que l'utilisateur se connecte avec l'application, un message est envoyé à l'arduino pour qu'il transmette les données à jour au serveur sur la conso actuelle.
  - Une fois que l'arduino fini de transmettre les données par requêtes post, il **envoie un message sur le topic "client\_{idDuClient}/update"**, pour envoyer un ok à l'appli, ce dernier peut maintenant fetch les données du compte par requête GET
  - Envoyer un changement d'état pour le compteur au système arduino + esp pour l'activer ou le désactiver par **le topic "client\_{idDuClient}/compteur"**.

### Mise en place :

Dans le fichier lib/utils/mqtt_helper.dart, mettre à la ligne 15 à la place de 10.0.2.2 le serveur broker.emqx.io si vous souhaitez utiliser un brocker en ligne ou conservez 10.0.2.2 si vous êtes en local pendant les tests sur emulateur.
Si vous souhaitez avoir votre brocker en local, vous devez installer mosquitto ou tout autre outil sur votre ordinateur capable de créer un serveur mqtt en local :

1. Installer mosquitto
2. Rendez vous à la racine de l'installation du logiciel : "C:/program files/mosquitto" certainement
3. Assurez vous d'avoir connecter l'ordinateur dans votre réseau local, ouvrez le port 1883 sur votre ordi (voir comment faire sur google)
4. Ouvrez le terminal et lancez la commande mosquitto
5. Ouvrez un autre terminal et tapez la commande ipconfig pour avoir votre adresse ip dans le réseau local (ipv4)
6. Renseignez cette adresse à la place de 10.0.2.2, 192.168.1.101 par exemple.

## - Démarrez le serveur laravel

  Faites un git clone du projet laravel lié à celui ci, c'est lui qui gère toute la logique d'authentification et la gestion des données. 
  Le système esp + arduino comme l'application mobile devront à un compte utilisateur par ce dernier pour initier leurs fonctionnement. 
  En envoyant une requête post à l'url dédiée avec les paramètres id_compteur et password dans le corps de la requête. 
  Cette requête retourne un objet JSON contenant une clé user et une clé token. Ce token de type Bearer devra être ajouter au header des requêtes protégées comme suit : "Authorization" : "Bearer {token}".
  Pour voir les url des requêtes veuillez consulter le projet Laravel.
  ### Mise en place
  Lancez le en suivant ces étapes :

1. Ouvrez le port 8000 ou autre port disponible souhaité sur votre machine (voir des tutos sur google).
2. Allez à la racine du projet laravel
3. Faites : composer install
4. Faites : npm install
5. Pour générer le fichier .env à partir de l'exemple : **cp .env.example .env**
6. Faites : **php artisan generate:key**
7. Le serveur se sert de sqlite donc pas de config necéssaire, faites : **php artisan migrate**
8. Pour démarrer le serveur à partir de votre ip local (192.168.1.101 par exemple et 7777 comme port ouvert) faites : **php artisan serve --host=192.168.1.101 --port=7777**
9. Enfin mettez cette ip dans lib/utils/laravel_backend.dart à la ligne 8 à l'intérieur de la variable base url

- Faites run votre application flutter ou faites le build de l'apk pour la mettre sur votre téléphone. Ce dernier doit être connecté au même réseau local
  C'est bon ! You are all set !
