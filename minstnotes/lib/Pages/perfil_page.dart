import 'package:flutter/material.dart';
import 'package:minstnotes/Widgets/scaffold.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultScaffold(
      title: 'Perfil',
      titleIcon: Icons.person,
      body: Center(child: Text('Perfil')),
    );
  }
}