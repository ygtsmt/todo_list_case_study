import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoMap extends StatefulWidget {
  const AddTodoMap({Key? key}) : super(key: key);

  @override
  _AddTodoMapState createState() => _AddTodoMapState();
}

class _AddTodoMapState extends State<AddTodoMap> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  LatLng? selectedPositionLatLng;
  Location location = Location();
  @override
  void initState() {
    super.initState();
    location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KONUM EKLE"),centerTitle: true,),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onTap: (LatLng latLng) {
              setState(() {
                markers.clear();
                markers.add(
                  Marker(
                    markerId: const MarkerId('customMarker'),
                    position: latLng,
                    infoWindow: const InfoWindow(title: 'Seçili Nokta'),
                  ),
                );
              });
            },
            markers: markers,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FilledButton(
                    onPressed: () async {
                      LocationData currentLocation = await location.getLocation();
                      saveData(currentLocation.latitude!, currentLocation.longitude!);
                    },
                    child: const Text("Konumu Ekle")),
                FilledButton(
                  onPressed: () async {
                    if (markers.isNotEmpty) {
                      final selectedMarker = markers.first;
                      final selectedPosition = selectedMarker.position;
                      saveData(selectedPosition.latitude, selectedPosition.longitude);

                      selectedPositionLatLng = selectedPosition;
                    }
                  },
                  child: const Text("İşaretli Noktayı Ekle"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  saveData(latitude, longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('selectedLatitude', latitude);
    await prefs.setDouble('selectedLongitude', longitude);
  }
}
