import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

homeAppBar() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: const AssetImage('assets/images/astro.jpeg'),
          ),
          const SizedBox(width: 16),
          Text(
            'Planet Expo',
            style: GoogleFonts.varelaRound(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
