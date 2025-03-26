import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planet_expo/screens/explore%20screen/explore_screen.dart';
import 'package:planet_expo/utils.dart';

class HomeThumbnailCard extends StatefulWidget {
  const HomeThumbnailCard({
    super.key,
  });

  @override
  State<HomeThumbnailCard> createState() => _HomeThumbnailCardState();
}

class _HomeThumbnailCardState extends State<HomeThumbnailCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // Bounce speed
    )..repeat(reverse: true); // Repeats up and down

    _bounceAnimation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        children: [
          // Thumbnail image And Tagline and Explore all button
          Positioned(
            left: -80,
            child: Row(
              children: [
                // Thumbnail image
                SizedBox(
                  height: 150,
                  width: 200,
                  child: Image.asset(
                    'assets/images/solar_sys.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Tagline
                SizedBox(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Thumbnail title
                      Text(
                        'Join the amazing galaxy world',
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        'Journey Beyond the Stars!',
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Explore all button
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.orange),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          selectedPlanetIndex = 0;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ExploreScreen(),
                          ));
                        },
                        child: const Text(
                          'Explore All',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Earth image
          // Bouncing Earth image
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Positioned(
                right: -38,
                bottom: _bounceAnimation.value,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/earth.png'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
