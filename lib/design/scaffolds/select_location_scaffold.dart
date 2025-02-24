import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:starter/design/widgets/placemark_widget.dart';
import 'package:starter/design/widgets/widgets.dart';
import 'package:geocoding/geocoding.dart' as geo;

class SelectLocationScaffold extends StatefulWidget {
  const SelectLocationScaffold({super.key, required this.onSelectLocation});
  final Function(LatLng latlng) onSelectLocation;

  @override
  State<SelectLocationScaffold> createState() => _SelectLocationScaffoldState();
}

class _SelectLocationScaffoldState extends State<SelectLocationScaffold> {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;
  bool showPlacemark = false;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Select Location",
      appBarAction: Visibility(
        visible: placemark != null && markers.length == 1,
        child: InkWell(
          onTap: () {
            widget.onSelectLocation(markers.first.position);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Select"),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-6.8957473, 107.6337669),
                zoom: 18,
              ),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              mapType: MapType.normal,
              onLongPress: (LatLng latLng) {
                onLongPressGoogleMap(latLng);
              },
            ),
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(Icons.my_location),
                onPressed: () async {
                  await _onMyLocationButtonPress();
                },
              ),
            ),
            if (placemark != null && showPlacemark)
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: PlacemarkWidget(
                  placemark: placemark!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street ?? "";
    final address = '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  Future<void> _onMyLocationButtonPress() async {
    try {
      final Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          if (kDebugMode) {
            print("Location services is not available");
          }
          return;
        }
      }
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (kDebugMode) {
            print("Location permission is denied");
          }
          return;
        }
      }

      LocationData locationData = await location.getLocation();
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);

      final info = await geo.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final place = info[0];
      final street = place.street ?? "";
      final address = '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      setState(() {
        placemark = place;
      });

      defineMarker(latLng, street, address);

      mapController.animateCamera(
        CameraUpdate.newLatLng(latLng),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
      onTap: () {
        setState(() {
          showPlacemark = !showPlacemark;
        });
      },
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
