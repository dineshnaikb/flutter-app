import 'dart:async';

import 'package:events/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class MapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller = Completer();

  String? _darkMapStyle;
  String? _lightMapStyle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/light.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    final theme = WidgetsBinding.instance!.window.platformBrightness;
    if (theme == Brightness.dark)
      controller.setMapStyle(_darkMapStyle);
    else
      controller.setMapStyle(_lightMapStyle);
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation =
        CameraPosition(zoom: 18, target: LatLng(37.807438, -122.419924));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
        elevation: 0,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: Icon(FontAwesomeIcons.filter))
        ],
        title: Image.asset(
          Theme.of(context).logo,
          width: 22.0.w,
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: initialLocation,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            _setMapStyle();
          }),
    );
  }
}
