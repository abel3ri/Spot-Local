import 'package:business_dir/app/data/models/app_error_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = "http://router.project-osrm.org/route/v1/driving/";
  }

  Future<Either<AppErrorModel, bool>> requestPermission() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return left(
          const AppErrorModel(
            body: "Location services are disabled. Please enable Location.",
          ),
        );
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return left(const AppErrorModel(body: "Location permission denied."));
        }

        if (permission == LocationPermission.deniedForever) {
          throw Exception("App is denied to use location.");
        }
      }
      return right(true);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, Position>> getCurrentPosition() async {
    try {
      final res = await requestPermission();
      return res.fold(
        (l) {
          return left(AppErrorModel(body: l.body));
        },
        (r) async {
          try {
            final userPosition = await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
              ),
            );
            return right(userPosition);
          } catch (e) {
            return left(AppErrorModel(body: e.toString()));
          }
        },
      );
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }

  Future<Either<AppErrorModel, List<LatLng>>> getRoutePoints({
    required LatLng userCoords,
    required LatLng businessCoords,
  }) async {
    try {
      final res = await get(
        "${userCoords.longitude},${userCoords.latitude};${businessCoords.longitude},${businessCoords.latitude}",
        query: {
          "steps": false,
          "annotations": false,
          "geometries": "geojson",
          "overview": "full",
        },
      );

      final coords =
          List.from(res.body['routes'][0]['geometry']['coordinates']);
      final routePoints = coords.map((coord) {
        return LatLng(coord[1], coord[0]);
      }).toList();
      return right(routePoints);
    } catch (e) {
      return left(AppErrorModel(body: e.toString()));
    }
  }
}
