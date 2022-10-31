import 'dart:async';

import 'package:fl_qrreader/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // leo lo que me mandan por la ruta como arguments
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments! as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      // target: LatLng(37.42796133580664, -122.085749655962),
      target: scan.getLanLng(),
      zoom: 17.5,
      tilt: 60,
    );

    //Marcadores:
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLanLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  target: scan.getLanLng(),
                  zoom: 17.5,
                  tilt: 60,
                )));
              },
              icon: Icon(Icons.location_searching)),
        ],
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        markers: markers,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
