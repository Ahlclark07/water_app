import 'dart:async';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uno/uno.dart';

class LaravelBackend {
  static final LaravelBackend _instance = LaravelBackend._internal();
  static String baseURL = "http://192.168.1.105:8000";
  final storage = const FlutterSecureStorage();

  static const String echec = "echec";
  static const String success = "success";
  Map<String, dynamic> user = {};
  Uno uno = Uno(
    baseURL: baseURL,
  );
  LaravelBackend._internal() {
    _initBackend();
  }

  factory LaravelBackend() {
    return _instance;
  }

  static void initialize() {}

  void _initBackend() {
    try {
      uno = Uno(baseURL: baseURL, headers: {"Accept": "application/json"});
    } catch (e) {
      print("Erreur lors de l'initialisation du backend : $e");
    }
  }

  Future<List<dynamic>> connexion({
    required String idCompteur,
    required String mdp,
  }) async {
    try {
      final FormData formData = FormData();
      formData.add("id_compteur", idCompteur);
      formData.add("password", mdp);

      final response = await uno.post("/login", data: formData);
      inspect(response.data);
      _instance.uno = Uno(baseURL: baseURL, headers: {
        "Authorization": "Bearer ${response.data["token"]}",
        "Accept": "application/json"
      });
      user = response.data["user"];
      inspect(user);

      await storage.write(key: "email", value: response.data["user"]["email"]);
      await storage.write(key: "mdp", value: response.data["user"]["password"]);
      return [LaravelBackend.success, response.data["user"]["nom"]];
    } on UnoError catch (e) {
      return [LaravelBackend.echec, e.message];
    }
  }

  Future<List<dynamic>> recupererConsommation() async {
    try {
      final response = await uno.get("/users/consommation");

      return [LaravelBackend.success, response.data["consommations"]];
    } on UnoError catch (e) {
      return [LaravelBackend.echec, e.message];
    }
  }

  Future<List<dynamic>> recupererNotifications() async {
    try {
      final response = await uno.get("/users/notifications");
      inspect(response.data["notifications"]);
      return [LaravelBackend.success, response.data["notifications"]];
    } on UnoError catch (e) {
      return [LaravelBackend.echec, e.message];
    }
  }

  Future<List<dynamic>> recupererAbonnement() async {
    try {
      final response = await uno.get("/users/abonnement");

      inspect(response.data);
      return [LaravelBackend.success, response.data["abonnement"]];
    } on UnoError catch (e) {
      return [LaravelBackend.echec, e.message];
    }
  }

  Future<List<dynamic>> inscription({
    required String nom,
    required String prenoms,
    required String tel,
    required String email,
    required String idCompteur,
    required String mdp,
  }) async {
    try {
      final FormData formData = FormData();
      formData.add("nom", nom);
      formData.add("prenoms", prenoms);
      formData.add("tel", tel);
      formData.add("email", email);
      formData.add("id_compteur", idCompteur);
      formData.add("password", mdp);
      final response = await uno.post("/register", data: formData);
      _instance.uno = Uno(baseURL: baseURL, headers: {
        "Authorization": "Bearer ${response.data["token"]}",
        "Accept": "application/json"
      });
      user = response.data["user"];
      const storage = FlutterSecureStorage();
      await storage.write(key: "email", value: response.data["user"]["email"]);
      await storage.write(key: "mdp", value: response.data["user"]["password"]);
      return [LaravelBackend.success, response.data["user"]["nom"]];
    } on UnoError catch (e) {
      inspect(e.message);
      return [LaravelBackend.echec, e.message];
    }
  }

  Future<List<dynamic>> deconnexion() async {
    await storage.deleteAll();
    uno = Uno(baseURL: baseURL, headers: {"Accept": "application/json"});
    final nom = user["nom"];
    user = {};
    return [success, "Aurevoir $nom !"];
  }
}
