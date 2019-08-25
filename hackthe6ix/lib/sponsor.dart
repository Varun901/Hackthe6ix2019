import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Sponsor extends StatefulWidget {
  @override
  _SponsorState createState() => _SponsorState();
}

class _SponsorState extends State<Sponsor> {
  GoogleMapController mapController;
  LatLng center;

  @override
  void initState() {
    super.initState();
    center = LatLng(45.521563, -122.677433);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (mapController) => mapController = mapController,
        initialCameraPosition: CameraPosition(target: center, zoom: 11),
      ),
    );
  }
}
