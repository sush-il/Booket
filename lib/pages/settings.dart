import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool dark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Container(
          margin: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Dark Mode",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                Switch(
                  value: dark,
                  activeColor: Colors.greenAccent,
                  onChanged: (bool value) {
                    setState(() {
                      dark = value;
                    });
                  },
                )
              ])
            ],
          )),
    ));
  }
}
