import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghumo_24/services/base_client.dart';
import 'package:ghumo_24/utills/textthem.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapUiBody extends StatefulWidget {
  final Map<String, dynamic> mydata;
  MapUiBody({Key? key, required this.mydata}) : super(key: key);

  @override
  State<MapUiBody> createState() => _MapUiBodyState();
}

class _MapUiBodyState extends State<MapUiBody> {
  String googleApikey = "AIzaSyAatarUnfCi0opdn9JPy6GNuwf0q3r6RBg";
  //contrller for Google map
  late GoogleMapController googleMapController;

  CameraPosition? initialCameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);

  Set<Marker> markers = {};

  String location = "Search Location";
  var address = "";
  var address2 = "";
  var city = "";
  var state = "";
  var pincode = "";
  var landmark = "";
  double lng2 = 0.0;
  double lat2 = 0.0;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
           iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Map<String, dynamic> data = {
                  "latitude": lat2,
                  "longitude": lng2,
                  "city": city,
                  "pincode": pincode,
                  "state": state,
                  "address": address,
                  "landmark": landmark,
                };
                Navigator.pop(context, data);
              },
              child: Icon(Icons.close)),
          title: Text(" Search Your Location ",style: Texttheme.labletext,),
          backgroundColor: Colors.white,
        ),
        body: Stack(children: [
          GoogleMap(
            onTap: (value) async {
              //when map drag stops

              initialCameraPosition = CameraPosition(
                  target: LatLng(initialCameraPosition!.target.latitude,
                      initialCameraPosition!.target.longitude),
                  zoom: 17);

              markers.clear();

              markers.add(Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: LatLng(initialCameraPosition!.target.latitude,
                      initialCameraPosition!.target.longitude)));

              List<Placemark> placemarks = await placemarkFromCoordinates(
                  initialCameraPosition!.target.latitude,
                  initialCameraPosition!.target.longitude);

              Placemark place = placemarks[0];
              city = "${place.locality}";
              pincode = "${place.postalCode}";
              state = "${place.administrativeArea}";
              landmark = '${place.street}';
              address2 =
                  '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';

              setState(() {
                lat2 = initialCameraPosition!.target.latitude;
                lng2 = initialCameraPosition!.target.longitude;
                BaseClient.box.write("latitude", lat2);
                BaseClient.box.write("longitude", lng2);
                // address =
                //     '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
              });
              setState(() {
                city = "${place.locality}";
                pincode = "${place.postalCode}";
                state = "${place.administrativeArea}";
                landmark = '${place.street}';

                address2 =
                    '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';

                //get place name from lat and lang
                address = placemarks.first.subLocality! +
                    ", " +
                    placemarks.first.subAdministrativeArea!;
              });
            },
            indoorViewEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            markers: markers,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              initialCameraPosition = cameraPositiona;
              //when map is dragging
            },
            onCameraIdle: () async {},
          ),

          //search autoconplete input
          Positioned(
              //search input bar
              top: 50,
              child: InkWell(
                  onTap: () async {
                    print(
                        "=========================dfghjk,=======================");
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'In')],
                        //google_map_webservice package
                        onError: (err) {
                          print(err);
                        });

                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                        address2 = place.description.toString();
                        address = place.description.toString();
                      });

                      //form google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeid = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                      final lat = geometry.location.lat;
                      final lang = geometry.location.lng;
                      var newlatlang = LatLng(lat, lang);

                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              geometry.location.lat, geometry.location.lng);

                      Placemark place2 = placemarks[0];
                      googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(lat, lang), zoom: 14)));

                      markers.clear();

                      markers.add(Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: LatLng(lat, lang)));

                      setState(() {
                          final lat = geometry.location.lat;
                      final lang = geometry.location.lng;

                        city = "${place2.locality}";
                        pincode = "${place2.postalCode}";
                        state = "${place2.administrativeArea}";
                        landmark = '${place2.street}';
                        BaseClient.box.write("latitude", lat);
                        BaseClient.box.write("longitude", lang);
                      });

                      //move map camera to selected place with animation
                      // googleMapController.animateCamera(
                      //     CameraUpdate.newCameraPosition(
                      //         CameraPosition(target: newlatlang, zoom: 17)));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            title: Text(
                              location,
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: Icon(Icons.search),
                            dense: true,
                          )),
                    ),
                  ))),

          Positioned(
              //widget to display location name
              bottom: 100,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        children: [
                          Text(
                            address2,
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextButton(
                                  onPressed: () {
                                    Map<String, dynamic> data = {
                                      "latitude": lat2,
                                      "longitude": lng2,
                                      "city": city,
                                      "pincode": pincode,
                                      "state": state,
                                      "address": address,
                                      "landmark": landmark,
                                    };
                                    Navigator.pop(context, data);
                                  },
                                  child: Text("Save Location")))
                        ],
                      )),
                ),
              ))
        ]));
  }
}
