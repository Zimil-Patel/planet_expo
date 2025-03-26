import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planet_expo/screens/home%20screen/components/home_app_bar.dart';
import 'package:planet_expo/screens/home%20screen/components/home_thumb_card.dart';
import 'package:planet_expo/screens/home%20screen/components/planet_list_tile.dart';
import 'package:planet_expo/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeAppBar(),

            // Thumbnail card with explore all planet button
            const HomeThumbnailCard(),

            const Padding(
              padding: EdgeInsets.only(
                bottom: 10.0,
                left: 20,
              ),
              child: Text(
                'Explore Universe',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // All Planet list
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => PlanetListTile(index: index),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white10,
                indent: 120,
              ),
              itemCount: planetList.length,
            ),
          ],
        ),
      ),
    );
  }
}
