import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TodoMapScreen extends StatefulWidget {
  const TodoMapScreen({super.key});

  @override
  State<TodoMapScreen> createState() => _TodoMapScreenState();
}

class _TodoMapScreenState extends State<TodoMapScreen> {
  late GoogleMapController mapController;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _setInitialCameraPosition();
  }

  Future<void> _setInitialCameraPosition() async {
    LocationData currentLocation = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("YOL TARİFİ"),
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(40.655381, 35.836891),
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
