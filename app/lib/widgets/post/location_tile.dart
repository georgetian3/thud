import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';


class LocationTile extends StatelessWidget {
  final double longitude;
  final double latitude;

  const LocationTile(this.longitude, this.latitude, {super.key});

  @override build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text('$longitude, $latitude'),
      onTap: () => MapsLauncher.launchCoordinates(latitude, longitude),
    );
  }

}