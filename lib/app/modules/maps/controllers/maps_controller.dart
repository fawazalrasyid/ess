import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ess/app/core/configs/constants.dart';
import 'package:ess/app/core/values/app_colors.dart';
import 'package:ess/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;

import '../../../data/services/prediction_service.dart';

class MapsController extends GetxController {
  final isLoading = false.obs;

  GoogleMapController? displayGoogleMapController;
  GoogleMapController? snapshotGoogleMapController;

  final TextEditingController searchCtrl = TextEditingController();

  final places = GoogleMapsPlaces(apiKey: Constants.GOOGLE_MAPS_API_KEY);
  final geocoding = GoogleMapsGeocoding(apiKey: Constants.GOOGLE_MAPS_API_KEY);

  var markers = <Marker>{}.obs;
  var polygons = <Polygon>{}.obs;

  final isAreaSelected = false.obs;
  final isPredictedResultVisible = false.obs;
  final isAlreadyPredicted = false.obs;

  final selectedAreaImage = ''.obs;
  final selectedAreaName = ''.obs;
  final selectedAreaCarbonStock = ''.obs;
  final selectedAreaBiomasa = ''.obs;

  final ScreenshotController screenshotController = ScreenshotController();
  final PredictionService predictionService = PredictionService();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: "Location service is disabled. Please enable it to proceed.",
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          msg:
              "Location permission is denied. Please grant permission to proceed.",
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        msg:
            "Location permissions are permanently denied, we cannot request permissions.",
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      updateCameraPosition(position.latitude, position.longitude);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to get current location: $e");
    }

    return;
  }

  void onSnapshotMapCreated(GoogleMapController controller) {
    snapshotGoogleMapController = controller;
  }

  void onMapCreated(GoogleMapController controller) {
    displayGoogleMapController = controller;
  }

  void searchAndNavigate(String searchText) async {
    var response = await places.searchByText(searchText);
    if (response.isOkay && response.results.isNotEmpty) {
      var place = response.results.first.geometry!.location;
      updateCameraPosition(place.lat, place.lng);
    } else {
      Fluttertoast.showToast(
        msg: "No results found.",
      );
    }
  }

  void updateCameraPosition(double latitude, double longitude) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );

    displayGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    snapshotGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void addMarker(Marker marker) {
    if (!isAlreadyPredicted.value) {
      markers.add(marker);
      updatePolygon();
      getSelectedAreaName(marker.position);
    }
  }

  void updatePolygon() {
    var polygon = Polygon(
      polygonId: const PolygonId('polygon'),
      points: markers.map((marker) => marker.position).toList(),
      strokeWidth: 2,
      strokeColor: AppColors.colorPrimary,
      fillColor: AppColors.colorPrimary.withOpacity(0.5),
    );
    polygons.clear();
    polygons.add(polygon);

    if (markers.length == 4) {
      isAreaSelected.value = true;
      zoomToPolygon(polygon);
    }
  }

  void zoomToPolygon(Polygon polygon) async {
    var bounds = _getPolygonBounds(polygon.points);
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 10);
    await displayGoogleMapController?.animateCamera(cameraUpdate);
    await snapshotGoogleMapController?.animateCamera(cameraUpdate);
  }

  LatLngBounds _getPolygonBounds(List<LatLng> points) {
    double southWestLat =
        points.map((point) => point.latitude).reduce((a, b) => a < b ? a : b);
    double southWestLng =
        points.map((point) => point.longitude).reduce((a, b) => a < b ? a : b);
    double northEastLat =
        points.map((point) => point.latitude).reduce((a, b) => a > b ? a : b);
    double northEastLng =
        points.map((point) => point.longitude).reduce((a, b) => a > b ? a : b);

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }

  Future<void> getSelectedAreaName(LatLng position) async {
    var response = await geocoding.searchByLocation(
      Location(lat: position.latitude, lng: position.longitude),
    );
    if (response.isOkay && response.results.isNotEmpty) {
      selectedAreaName.value = response.results.first.formattedAddress ?? '';
    } else {
      selectedAreaName.value = 'Unknown area';
    }
  }

  void clearSelectedArea() {
    markers.clear();
    polygons.clear();
    isAreaSelected.value = false;
    isPredictedResultVisible.value = false;
    isAlreadyPredicted.value = false;
    selectedAreaCarbonStock.value = '-';
    selectedAreaBiomasa.value = '-';
  }

  void togglePredict(bool value) {
    isPredictedResultVisible.value = value;

    if (value) {
      if (isAlreadyPredicted.value) {
        isPredictedResultVisible.value = true;
      } else if (isAreaSelected.value) {
        predictSelectedArea();
      } else {
        isPredictedResultVisible.value = false;
        Fluttertoast.showToast(msg: 'Pilih area terlebih dahulu');
      }
    } else {
      isPredictedResultVisible.value = false;
    }
  }

  Future<void> predictSelectedArea() async {
    isLoading.value = true;

    try {
      snapshotGoogleMapController?.takeSnapshot().then(
        (Uint8List? image) async {
          if (image != null) {
            final img.Image decodedImage = img.decodeImage(image)!;
            final img.Image resizedImage = img.copyResize(
              decodedImage,
              width: 500,
            );
            final Uint8List compressedImage = Uint8List.fromList(
              img.encodeJpg(resizedImage, quality: 100),
            );

            final directory = await getApplicationDocumentsDirectory();
            final imagePath = File('${directory.path}/selected_area.png');
            await imagePath.writeAsBytes(compressedImage);

            final result = await predictionService.predictImage(imagePath.path);

            selectedAreaImage.value = imagePath.path;
            selectedAreaCarbonStock.value = result.predictedClass;
            selectedAreaBiomasa.value = 'N/A';
            isAlreadyPredicted.value = true;
          } else {
            Fluttertoast.showToast(msg: 'Terjadi kesalahan');
          }
        },
      );
    } catch (e) {
      debugPrint('Failed to predict image: $e');
      Fluttertoast.showToast(msg: 'Terjadi kesalahan');
    }

    isLoading.value = false;
  }

  void detailMapping() {
    Get.toNamed(Routes.DETAIL_MAPPING, arguments: {
      'image': selectedAreaImage.value,
      'name': selectedAreaName.value,
      'carbonStock': selectedAreaCarbonStock.value,
      'biomasa': selectedAreaBiomasa.value,
    });
  }
}
