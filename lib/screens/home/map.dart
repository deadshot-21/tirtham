import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tirtham/constants.dart';
import 'package:tirtham/screens/home/prLoader.dart';
import 'package:tirtham/screens/home/waterQuality.dart';
import 'package:tirtham/utils/snack.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double lat = 51.5;
  double lng = -0.09;
  String message = "";
  bool isLoading = true;
  bool isClicked = false;
  var storage = const FlutterSecureStorage();
  var dio = Dio();

  void checkPermission() async {
    bool _serviceEnabled;
    Location location = Location();
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Error');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Error');
      }
    }
  }

  void setLocation(currentLocation) {
    print(currentLocation);
    setState(() {
      lat = currentLocation.latitude!;
      lng = currentLocation.longitude!;
    });
  }

  void getLocation() async {
    print('hello');
    LocationData _locationData;
    Location location = Location();
    _locationData = await location.getLocation();
    setLocation(_locationData);
    setState(() {
      isLoading = false;
    });
    // location.onLocationChanged.listen((LocationData currentLocation) {

    // });

    // setState((){
    //   location.onLocationChanged.listen((LocationData currentLocation) {
    //   lat = _locationData.latitude!;
    //   lng = _locationData.longitude!;
    //   isLoading=false;
    // });
    // });
    print(lng);
    print(lat);
    print(_locationData);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Scaffold(
            // backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
                // strokeWidth: 2.0,
              ),
            ),
          )
        : Scaffold(
            // appBar: AppBar(
            //   title: const Text('Live location'),
            //   centerTitle: true,
            //   backgroundColor: Colors.transparent,
            //   toolbarHeight: kToolbarHeight + 20.0,
            //   foregroundColor: kDark,
            // ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.my_location_rounded),
              // foregroundColor: MediaQuery.of(context).platformBrightness ==
              //                           Brightness.light
              //                       ? kDark[900]
              //                       : Colors.white,
              foregroundColor: kPrimaryColor,
              onPressed: () {
                getLocation();
              },
            ),
            body: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                      center: LatLng(lat, lng),
                      zoom: 18.0,
                      onTap: (tapPos, latLong) {
                        setLocation(latLong);
                      }),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      attributionBuilder: (_) {
                        return const Text("");
                      },
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(lat, lng),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on_rounded,
                              color: kDark[800],
                              size: 54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: kDefaultPadding,
                  right: kDefaultPadding * 2 + 100.0,
                  left: kDefaultPadding,
                  child: GestureDetector(
                    onTap: () async {
                      // setState(() {
                      //   isClicked = true;
                      // });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return PrLoader();
                        }),
                      );
                      Response response = await dio.post(
                        'https://447f-175-100-134-52.in.ngrok.io/getReflectanceM',
                        options: Options(headers: {
                          HttpHeaders.contentTypeHeader: "application/json",
                        }),
                        // data: jsonEncode(value),
                        data: {"lat": lat, "long": lng},
                      );
                      if (!mounted) return;
                      // setState(() {
                      //   isClicked = false;
                      // });
                      if (response.data['status'] == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return WaterQuality(lat: lat, long: lng, res: response.data['data']);
                        }),
                      );
                      } else {
                        Navigator.of(context).pop();
                        showSnack(context, 'Error: ${response.data['message']}: ${response.data['error']}', () {}, 'OK', 4);
                      }
                      // var token = await storage.read(key: "token");
                      // Response response = await dio.post(
                      //   'https://api-ecolyf-alt.herokuapp.com/home/end',
                      //   options: Options(headers: {
                      //     HttpHeaders.contentTypeHeader: "application/json",
                      //     HttpHeaders.authorizationHeader:"Bearer " + token!,

                      //   }),
                      //   // data: jsonEncode(value),
                      //   data: {

                      //   },
                      // );
                      // if (response.data['status'] != true) {
                      //   setState(() {
                      //     message = response.data['message'];
                      //   });
                      // } else {
                      //   print(response.data);
                      //   // Navigator.of(context).pop();
                      //    Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) {
                      //     return const Home();
                      //   }),
                      //   );
                      //   // print(response.toString());
                      // }
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: kPrimaryColorAccent,
                        color: kPrimaryColor,
                        elevation: 5.0,
                        child: 
                        // isClicked
                        //     ? Center(
                        //         child: Transform.scale(
                        //           scale: 0.5,
                        //           child: CircularProgressIndicator(
                        //             color: kLight,
                        //             // strokeWidth: 2.0,
                        //           ),
                        //         ),
                        //       )
                        //     : 
                            Center(
                                child: Text(
                                  'Check quality',
                                  style: TextStyle(
                                    // fontFamily: 'Raleway',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
