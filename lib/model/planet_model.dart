import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:planet_expo/utils.dart';

class Planet {
  final String gif;
  final String name;
  final String secondName;
  final PlanetDetails details;

  Planet({
    required this.gif,
    required this.name,
    required this.secondName,
    required this.details,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      gif: 'assets/gif/${json['name'].toString().toLowerCase()}.gif',
      name: json['name'],
      secondName: json['secondName'],
      details: PlanetDetails.fromJson(
        json['details'],
      ),
    );
  }
}

class PlanetDetails {
  final String radius;
  final String distanceFromSun;
  final String moons;
  final String gravity;
  final String tiltOfAxis;
  final String lengthOfYear;
  final String lengthOfDay;
  final String temperature;

  PlanetDetails({
    required this.radius,
    required this.distanceFromSun,
    required this.moons,
    required this.gravity,
    required this.tiltOfAxis,
    required this.lengthOfYear,
    required this.lengthOfDay,
    required this.temperature,
  });

  factory PlanetDetails.fromJson(Map<String, dynamic> json) {
    return PlanetDetails(
      radius: json['Radius'],
      distanceFromSun: json['Distance from sun'],
      moons: json['Moons'],
      gravity: json['Gravity'],
      tiltOfAxis: json['Tilt of Axis'],
      lengthOfYear: json['Length of Year'],
      lengthOfDay: json['Length of Day'],
      temperature: json['Temperature'],
    );
  }
}

// Convert from json to model list
Future<void> convertFromJsonToModel() async {
  final String json = await rootBundle.loadString('assets/json/planets.json');
  final data = jsonDecode(json);
  planetList =
      (data['planets'] as List).map((e) => Planet.fromJson(e)).toList();
  log(planetList.length.toString());
}
