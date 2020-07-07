import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../screens/CalenderScreen/screens/MapScreen.dart';
import '../widgets/LightIconButton.dart';

class LocationInput extends StatefulWidget {

  final Function selectPlace;
  final Position position;

  LocationInput(this.selectPlace, {this.position});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String _previewImageUrl;

  void getExistingLocation() {
    if (widget.position != null) {
      setState(() {
        _previewImageUrl = '';
      });
    }
  }

  Future<void> _getCurrentUserLocation() async {
    final myLocation = await Geolocator().getCurrentPosition();
    setState(() {
      _previewImageUrl = '';
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
    setState(() {
      _previewImageUrl = '';
    });
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  void initState() {
    getExistingLocation();
    super.initState();
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
              ),
              color: _previewImageUrl == null ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2)
            ),
            child: _previewImageUrl == null ?
              Text("Select Location") :
              Text("Location Selected"),
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