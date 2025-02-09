import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minstnotes/Widgets/drawer_down.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final TextStyle? titleTextStyle;

  const DefaultScaffold({
    super.key,
    required this.body,
    this.title = '',
    this.titleTextStyle,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 30, 159, 199),
      title: Text(
        title,
        style: titleTextStyle ?? GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    ),
      body: const DrawerDown(),
      floatingActionButton: floatingActionButton,
    );
  }
}
