import 'package:flutter/material.dart';
import 'package:planet_expo/screens/home%20screen/components/home_app_bar.dart';
import 'package:planet_expo/screens/home%20screen/components/home_thumb_card.dart';

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

      // App bar
      appBar: homeAppBar(),

      // Body
      body: Column(
        children: [
          // Thumbnail card with explore all planet button
          HomeThumbnailCard(),

          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
