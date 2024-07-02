import 'package:eau/design.dart';
import 'package:eau/utils/mqtt_helper.dart';
import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  final MqttHandler mqttHandler;
  final bool isSwitched;
  const ToggleSwitch(this.mqttHandler, {super.key, required this.isSwitched});

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = false;

  void _toggleSwitch(bool value) {
    widget.mqttHandler.publishEtatCompteurMessage(value);
    setState(() {
      isSwitched = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSwitched = widget.isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: isSwitched,
          onChanged: _toggleSwitch,
          activeTrackColor: Palette.couleur_bleu,
          activeColor: Palette.couleur_blanche,
        ),
        const Text("ON/OFF")
      ],
    );
  }
}
