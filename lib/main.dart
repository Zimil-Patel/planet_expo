import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlanetScreen(),
    );
  }
}

class PlanetScreen extends StatefulWidget {
  const PlanetScreen({super.key});

  @override
  State<PlanetScreen> createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainPlanetAnimationController;
  late final mainPlanetAnimation;

  _initMainPlanetAnimation() {
    _mainPlanetAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    mainPlanetAnimation = Tween<Offset>();
  }

  int selectedPlanetIndex = 0; // Track selected planet index
  final PageController _pageController = PageController(viewportFraction: 0.4);

  final List<Map<String, String>> planets = [
    {
      "name": "Mars",
      "image": "assets/gif/mars.gif",
      "description": "The Red Planet",
    },
    {
      "name": "Venus",
      "image": "assets/gif/venus.gif",
      "description": "Earth’s Twin",
    },
    {
      "name": "Jupiter",
      "image": "assets/gif/jupiter.gif",
      "description": "The Gas Giant",
    },
    {
      "name": "Mercury",
      "image": "assets/gif/mercury.gif",
      "description": "The Mercury",
    },
    {
      "name": "Earth",
      "image": "assets/gif/earth.gif",
      "description": "The Life",
    },
    {
      "name": "Uranus",
      "image": "assets/gif/uranus.gif",
      "description": "The Uranus",
    },
    {
      "name": "Pluto",
      "image": "assets/gif/pluto.gif",
      "description": "The Pluto",
    },
    {
      "name": "Neptune",
      "image": "assets/gif/neptune.gif",
      "description": "The Neptune",
    },
    {
      "name": "Saturn",
      "image": "assets/gif/saturn.gif",
      "description": "The Saturn",
    },
  ];

  @override
  void initState() {
    _initMainPlanetAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Planet Info Section (Updated when selected planet changes)
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(planets[selectedPlanetIndex]["image"]!,
                    height: 250), // Planet Image
                const SizedBox(height: 20),
                Text(
                  planets[selectedPlanetIndex]["name"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  planets[selectedPlanetIndex]["description"]!,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 97,
            right: 17,
            child: Container(
              height: 86,
              width: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.orange,
                  width: 2,
                ),
              ),
            ),
          ),

          // Bottom-Right Planet Selection (Vertical PageView with Fade Effect)
          Positioned(
            bottom: 50,
            right: 20,
            child: SizedBox(
              height: 180, // Adjust height for fade effect
              width: 80, // Keep width consistent
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: planets.length,
                clipBehavior: Clip.none,
                onPageChanged: (index) {
                  setState(() {
                    selectedPlanetIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  double opacity = index == selectedPlanetIndex ? 1.0 : 0.5;
                  double scale = index == selectedPlanetIndex ? 1.08 : 0.6;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanetIndex = index;
                      });
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Image.asset(
                          planets[index]["image"]!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
