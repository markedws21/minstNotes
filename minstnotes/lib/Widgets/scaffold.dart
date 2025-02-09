import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final TextStyle? titleTextStyle;
  
  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.titleTextStyle,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(title,
        style: titleTextStyle ?? GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 30, 159, 199),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
