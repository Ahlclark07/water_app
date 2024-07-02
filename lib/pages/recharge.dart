import 'package:eau/design.dart';
import 'package:eau/utils/mqtt_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final controller = TextEditingController();
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect(recharge: true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recharger votre compteur"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.couleur_bleu,
          ),
        ),
      ),
      body: Container(
        width: width,
        padding: Marge.margeMiniPage,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Entrez le montant de votre recharge",
                  textAlign: TextAlign.left,
                  style: TextDesign.text_bleu.copyWith(fontSize: 15)),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width - 60,
                child: Container(
                    decoration: ContainerDecoration.button_principale
                        .copyWith(color: Palette.couleur_bleu.withAlpha(100)),
                    child: FormBuilderTextField(
                      name: "montant",
                      controller: controller,
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.integer(
                          errorText: "Entrez un nombre"),
                      decoration: TextFieldDecoration.champ,
                      cursorColor: Palette.couleur_blanche,
                      style: TextDesign.text_blanc,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.isValid) {
                      mqttHandler.publishRecharge(controller.text);
                      // Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: width - 60,
                      padding: Marge.margeBoutons,
                      decoration: ContainerDecoration.button_secondaire,
                      child: const Text(
                        "Recharger",
                        style: TextDesign.text_blanc,
                        textAlign: TextAlign.center,
                      ))),
              ValueListenableBuilder(
                  valueListenable: mqttHandler.data,
                  builder: (context, value, _) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          textAlign: TextAlign.center,
                          "Code : ${value.isEmpty ? "En attente" : value}"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
