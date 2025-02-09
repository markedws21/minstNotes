import 'package:flutter/material.dart';
import 'package:minstnotes/Widgets/scaffold.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      title: 'Configuraciones',
      titleIcon: Icons.settings,
      body: Center(child: Text('Configuraciones')),
    );
  }
}