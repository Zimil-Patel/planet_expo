import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planet_expo/screens/explore%20screen/explore_screen.dart';
import 'package:planet_expo/utils.dart';

class PlanetListTile extends StatelessWidget {
  const PlanetListTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedPlanetIndex = index;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ExploreScreen(),
          ),
        );
      },
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 50, right: 60),
                height: 100,
                padding: const EdgeInsets.only(left: 80, right: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(100),
                    right: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Planet name
                    Text(
                      planetList[index].name,
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // Second name
                    Text(
                      planetList[index].secondName,
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Radius
                    Text(
                      planetList[index].details.radius,
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Planet image
            Hero(
              tag: planetList[index].name,
              child: SizedBox(
                height: 120,
                width: 120,
                child: Image.asset(planetList[index].gif),
              ),
            ),

            // planet count
            Positioned(
              right: -80,
              top: 10,
              child: SizedBox(
                height: 120,
                width: 120,
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.varelaRound(
                    textStyle: const TextStyle(
                      fontSize: 50,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
