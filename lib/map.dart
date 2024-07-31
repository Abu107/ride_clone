import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_marker_animation/core/ripple_marker.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride/widgets/side_navigation.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  double lat = 0, lng = 0;
  LatLng? latn;
  //final controller = Completer<GoogleMapController>();
  final kMarkerId = MarkerId('MarkerId1');
  final markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(8.99283657434915, 38.67542791914769),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];
  LatLng baseLocation = LatLng(9.023413552733823, 38.670411146843215);
  LatLng? _currentPosition;
  bool isLoading = true;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    super.initState();
    getLocation();
    addCustomIcon();
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      isLoading = false;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.031551234508504, 38.732209242683496),
    zoom: 18.5,
  );

  /*static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.002374618982007, 38.67446601394125),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  void newLocationUpdate(LatLng latLng) {
    var marker = RippleMarker(
      markerId: kMarkerId,
      position: latLng,
      ripple: true,
    );
    setState(() => markers[kMarkerId] = marker);
  }
*/
  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "images/car.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image.asset("images/ride.png"),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.amber),
                    ),
                  ]),
            )
          : Stack(
              children: [
                Animarker(
                  mapId: _controller.future.then<int>((value) => value.mapId),
                  curve: Curves.bounceInOut,
                  useRotation: true,
                  rippleRadius: 0.5, //[0,1.0] range, how big is the circle
                  rippleColor: Color.fromARGB(
                      255, 17, 170, 155), // Color of fade ripple circle
                  rippleDuration:
                      Duration(milliseconds: 2500), //Pulse ripple duration
                  duration: Duration(milliseconds: 2000),
                  /*markers: <Marker>{
              //Ripple Marker
              RippleMarker(
                markerId: MarkerId('MarkerId1'),
                position: LatLng(8.992949604589064, 38.676104137397246),
                ripple: true, //Ripple state
              ),
              //Non-ripple marker
              Marker(
                markerId: MarkerId('MarkerId2'),
                position: LatLng(8.99345674332983, 38.67605186999274),
              ),
            },*/
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: _currentPosition ?? baseLocation, zoom: 18.5),
                    markers: {
                      Marker(
                          markerId: const MarkerId("marker1"),
                          position:
                              const LatLng(8.99283657434915, 38.67542791914769),
                          draggable: true,
                          onDragEnd: (value) {
                            // value is the new position
                          },
                          // To do: custom marker icon
                          icon: markerIcon),
                      Marker(
                        markerId: const MarkerId("marker2"),
                        position:
                            const LatLng(8.992949604589064, 38.676104137397246),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      //controller.complete(gController);//Complete the future GoogleMapController
                      _controller.complete(controller);
                    },
                    mapToolbarEnabled: true,
                    buildingsEnabled: true,
                  ),
                ),
                Scaf()
              ],
            ),
      drawer: DrawerClass(context),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}

class Scaf extends StatelessWidget {
  const Scaf({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(Icons.menu)),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text("Top up wallet"),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(left: 15),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/restaurant.png",
                        width: 30,
                        height: 30,
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Food delivery",
                                style: TextStyle(fontSize: 16),
                              ))),
                      Image.asset(
                        "images/pizza3.png",
                        height: 50,
                        width: 50,
                      )
                    ],
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 50,
                      padding: EdgeInsets.all(15),
                      child: Center(
                          child: Text(
                        textAlign: TextAlign.center,
                        "Order now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 50,
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Icon(Icons.lock_clock),
                  ),
                ],
              ),
            ),
            // child: FloatingActionButton(onPressed: (){},child: Text("Order now"),)
          ),
        ],
      ),
    );
  }
}
