import 'package:permission_handler/permission_handler.dart';

requestLocationPermission() async {
  var status = await Permission.location.request();
  if (status.isGranted) {
  } else if (status.isDenied) {
    requestLocationPermission();
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}
