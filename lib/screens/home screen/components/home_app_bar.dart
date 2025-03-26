import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar homeAppBar() {
  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      children: [
        const CircleAvatar(
          backgroundImage: const AssetImage('assets/images/astro.jpeg'),
        ),
        const SizedBox(width: 16),
        Text(
          'Planet Expo',
          style: GoogleFonts.varelaRound(
            textStyle: const TextStyle(
              color: Colors.white30,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}
