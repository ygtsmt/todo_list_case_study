import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
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
  String? arrrivedTimeSecond;
  String? arrrivedTimeMinutes;
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
        title: const Text("YOL TARİFİ"),
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        GoogleMap(
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
        Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$arrrivedTimeMinutes Dakika $arrrivedTimeSecond Saniye"),
            ))
      ]),
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
      calculateAndPrintTravelTime();
    });
  }

  Future<Duration?> calculateTravelTime() async {
    /*  final startLocation = LocationData.fromMap({"latitude": startLatitude, "longitude": startLongitude});
  final endLocation = LocationData.fromMap({"latitude": endLatitude, "longitude": endLongitude}); */

    try {
      final distance = Geolocator.distanceBetween(
          user_location!.latitude, user_location!.longitude, widget.location.latitude, widget.location.longitude);

      const averageSpeedKph = 50;
      final travelTimeHours = distance / (averageSpeedKph * 1000);
      final travelTimeMinutes = travelTimeHours * 60;
      final travelTimeSeconds = travelTimeMinutes * 60;
      return Duration(
          hours: travelTimeHours.toInt(), minutes: travelTimeMinutes.toInt(), seconds: travelTimeSeconds.toInt());
    } catch (e) {
      print("Seyahat süresi hesaplanırken bir hata oluştu: $e");
      return null;
    }
  }

  Future<void> calculateAndPrintTravelTime() async {
    final travelTime = await calculateTravelTime();

    if (travelTime != null) {
      final minutes = travelTime.inMinutes;
      final seconds = travelTime.inMinutes % 60;

      setState(() {
        arrrivedTimeMinutes = minutes.toString();
        arrrivedTimeSecond = seconds.toString();
        debugPrint("$arrrivedTimeMinutes  $arrrivedTimeSecond");
      });
    } else {
      print('Seyahat süresi hesaplanamadı.');
    }
  }
}
