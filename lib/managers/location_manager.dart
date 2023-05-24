import 'package:geolocator/geolocator.dart';

class LocationManager {
  LocationManager();

  Future getCurrentPosition() async {
    if (!await isPermissionGranted()) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> isPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.value(false);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }
}
