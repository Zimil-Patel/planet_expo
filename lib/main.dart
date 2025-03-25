import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planet_expo/model/planet_model.dart';
import 'package:planet_expo/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await convertFromJsonToModel();
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
  // Animation controller
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  final PageController _pageController =
      PageController(viewportFraction: 0.4, initialPage: selectedPlanetIndex);

  void _initializeAnimations() {
    _animations = List.generate(
      8, // Number of detail fields
      (index) => Tween<Offset>(
        begin: const Offset(0, 20), // Starts from bottom
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (index * 0.1), // Staggered delay effect
          1.0,
          curve: Curves.easeOut,
        ),
      )),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Total duration
      vsync: this,
    );
    _initializeAnimations();
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
            ),
          ),

          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main Planet Info Section (Updated when selected planet changes)
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Planet name
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    planetList[selectedPlanetIndex].name.toUpperCase(),
                    key: ValueKey('name$selectedPlanetIndex'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Planet tagline
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    planetList[selectedPlanetIndex].secondName,
                    key: ValueKey('desc$selectedPlanetIndex'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Animated planet gif
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final slideAnimation = Tween<Offset>(
                      begin: const Offset(-1.5, 0), // New one comes from left
                      end: const Offset(0, 0),
                    ).animate(animation);

                    return SlideTransition(
                        position: slideAnimation, child: child);
                  },
                  child: Image.asset(
                    planetList[selectedPlanetIndex].gif,
                    key: ValueKey(
                        selectedPlanetIndex), // Ensure smooth transition
                    height: 250,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 147,
            right: -33,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                Container(
                  height: 1,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom-Right Planet Selection (Vertical PageView with Fade Effect)
          Positioned(
            bottom: 100,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Discover',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 180, // Adjust height for fade effect
                  width: 80, // Keep width consistent
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: planetList.length,
                    clipBehavior: Clip.none,
                    onPageChanged: (index) {
                      setState(() {
                        selectedPlanetIndex = index;
                        _controller.reset();
                        _controller.forward();
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
                              planetList[index].gif,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Planet details
          Positioned(
            bottom: 0,
            left: 20,
            child: SizedBox(
              height: 400,
              width: 220,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                key: ValueKey('detail$selectedPlanetIndex'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    8,
                    (index) {
                      return SlideTransition(
                        position: _animations[index],
                        child: detailTextView(
                          label: _getDetailLabel(index),
                          value: _getDetailValue(index),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // More option button
          Positioned(
            bottom: 50,
            left: 20,
            child: Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.orange,
                ),
              ),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.orange,
              ),
            ),
          ),

          // More option button
          Positioned(
            top: 40,
            left: 16,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(
                    width: 2,
                    color: Colors.orange,
                  ),
                ),
                child: const Icon(
                  Icons.home,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailTextView({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  // Helper function to get labels
  String _getDetailLabel(int index) {
    List<String> labels = [
      'Radius',
      'Distance from Sun',
      'Moons',
      'Gravity',
      'Tilt of Axis',
      'Length of Year',
      'Length of Day',
      'Temperature',
    ];
    return labels[index];
  }

  // Helper function to get values
  String _getDetailValue(int index) {
    List<String> values = [
      planetList[selectedPlanetIndex].details.radius,
      planetList[selectedPlanetIndex].details.distanceFromSun,
      planetList[selectedPlanetIndex].details.moons,
      planetList[selectedPlanetIndex].details.gravity,
      planetList[selectedPlanetIndex].details.tiltOfAxis,
      planetList[selectedPlanetIndex].details.lengthOfYear,
      planetList[selectedPlanetIndex].details.lengthOfDay,
      planetList[selectedPlanetIndex].details.temperature,
    ];
    return values[index];
  }
}
