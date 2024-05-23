import 'dart:async';

import 'package:ess/app/core/configs/constants.dart';
import 'package:ess/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends GetxController {
  final isLoading = false.obs;

  GoogleMapController? googleMapController;

  final TextEditingController searchCtrl = TextEditingController();

  final places = GoogleMapsPlaces(apiKey: Constants.GOOGLE_MAPS_API_KEY);

  var markers = <Marker>{}.obs;
  var polygons = <Polygon>{}.obs;

  final isCarbonVisible = false.obs;
  final selectedAreaCarbonStock = 0.obs;
  final selectedAreaBiomasa = 0.obs;

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

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
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
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
      ),
    );
  }

  void addMarker(Marker marker) {
    markers.add(marker);
    updatePolygon();
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
  }

  void clearAll() {
    markers.clear();
    polygons.clear();
  }

  void showCarbonStock(value) {
    isLoading.value = true;

    isCarbonVisible.value = value;

    if (value) {
      Timer(const Duration(seconds: 2), () async {
        selectedAreaCarbonStock.value = 50;
        selectedAreaBiomasa.value = 50;
      });
    } else {
      selectedAreaCarbonStock.value = 0;
      selectedAreaBiomasa.value = 0;
    }

    isLoading.value = false;
  }
}
