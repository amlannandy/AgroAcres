import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../screens/MapScreen.dart';
import '../../../widgets/LightIconButton.dart';
import '../../../services/LocationProvider.dart';

class LocationInput extends StatefulWidget {

  final Function selectPlace;

  LocationInput(this.selectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final myLocation = await Geolocator().getCurrentPosition();
    final staticMapUrl = LocationProvider.generateLocationPreviewImage(myLocation.latitude, myLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.selectPlace(myLocation.latitude, myLocation.longitude);
  }

  Future<void> _selectOnMap() async {
    final Position selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MapScreen()),
    );
    if (selectedLocation == null) {
      return;
    }
    final staticMapUrl = LocationProvider.generateLocationPreviewImage(selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              )
            ),
            child: _previewImageUrl == null ?
              Text("Select Location") :
              Image.network(
                _previewImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            alignment: Alignment.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              LightIconButton(
                icon: Icons.my_location,
                text: "My Location",
                function: _getCurrentUserLocation,
              ),
              LightIconButton(
                icon: Icons.location_on,
                text: "Pick on Map",
                function:  _selectOnMap,
              ),
            ],
          )
        ],
      ),
    );
  }
}