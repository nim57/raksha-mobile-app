import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextContent extends StatefulWidget {

  final String title;
  final String description;

  const TextContent({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<TextContent> createState() => _TextContentState();
}

class _TextContentState extends State<TextContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.2,
              color: const Color(0xFFE4E2E4),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: const Color(0xFFE7BDB7),
            ),
          ),
        ],
      ),
    );
  }
}