import 'dart:async';

import 'package:ess/app/core/configs/constants.dart';
import 'package:ess/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapsController extends GetxController {
  final isLoading = false.obs;

  GoogleMapController? googleMapController;
  final loc.Location location = loc.Location();

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
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: "Location service is disabled. Please enable it to proceed.",
      );
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        Fluttertoast.showToast(
          msg:
              "Location permission is denied. Please grant permission to proceed.",
        );
        return;
      }
    }

    locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      updateCameraPosition(locationData.latitude!, locationData.longitude!);
    } else {
      Fluttertoast.showToast(msg: "Failed to get current location.");
    }
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
