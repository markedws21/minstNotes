import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final TextStyle? titleTextStyle;
  final IconData? titleIcon;
  final EdgeInsetsGeometry? padding;

  const DefaultScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.titleTextStyle,
    this.titleIcon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleIcon != null) ...[
              Icon(titleIcon, color: Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: titleTextStyle ??
                  GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 30, 159, 199),
      ),
      body: Padding(
        padding: padding ?? const EdgeInsets.all(16.0), // Padding predeterminado
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
