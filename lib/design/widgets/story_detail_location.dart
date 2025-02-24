import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:starter/design/widgets/placemark_widget.dart';

class StoryDetailLocation extends StatefulWidget {
  const StoryDetailLocation({
    super.key,
    required this.latLng,
    required this.id,
  });

  final LatLng latLng;
  final String id;

  @override
  State<StoryDetailLocation> createState() => _StoryDetailLocationState();
}

class _StoryDetailLocationState extends State<StoryDetailLocation> {
  geo.Placemark? placemark;
  bool showPlacemark = false;

  @override
  void initState() {
    _placemark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: 18,
          ),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          scrollGesturesEnabled: false,
          mapType: MapType.normal,
          markers: {
            Marker(
              markerId: MarkerId(widget.id),
              position: widget.latLng,
              onTap: () async {
                if (placemark == null) {
                  await _placemark();
                }
                setState(() {
                  showPlacemark = !showPlacemark;
                });
              },
            )
          },
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
    );
  }

  Future<void> _placemark() async {
    final info = await geo.placemarkFromCoordinates(
      widget.latLng.latitude,
      widget.latLng.longitude,
    );

    final place = info[0];

    setState(() {
      placemark = place;
    });
  }
}
