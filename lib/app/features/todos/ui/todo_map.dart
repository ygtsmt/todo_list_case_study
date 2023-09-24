import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TodoMapScreen extends StatefulWidget {
  final GeoPoint location;
  const TodoMapScreen({super.key, required this.location});

  @override
  State<TodoMapScreen> createState() => _TodoMapScreenState();
}

class _TodoMapScreenState extends State<TodoMapScreen> {
  GoogleMapController? mapController;
  Location location = Location();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PointLatLng? user_location;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.location.latitude.toString()),
      ),
      body: GoogleMap(
        markers: markers,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: CameraPosition(
          tilt: 90,
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 12.5,
        ),
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              mapController = controller;
              makeLines(user_location!, PointLatLng(widget.location.latitude, widget.location.longitude));
              markers.add(
                Marker(
                  markerId: const MarkerId('customMarker'),
                  position: LatLng(widget.location.latitude, widget.location.longitude),
                  infoWindow: const InfoWindow(title: 'Seçili Nokta'),
                ),
              );
            });
          });
        },
      ),
    );
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  void makeLines(PointLatLng startingLatLng, PointLatLng endLatLng) async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyDVyFWb5XQugTwcRWp5El-ajr5x0cUcnJ8',
      startingLatLng,
      endLatLng, 

      travelMode: TravelMode.driving,
    )
        .then((value) {
      for (var point in value.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }).then((value) {
      addPolyLine();
    });
  }

  _getLocation() async {
    LocationData currentLocation = await location.getLocation();
    setState(() {
      user_location = PointLatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }
}
