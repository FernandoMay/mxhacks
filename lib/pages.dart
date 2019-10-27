import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:mxhck/alarmas.dart';
import 'package:mxhck/nuevaM.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DisplayListView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_alarm,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: newMed(),
              type: PageTransitionType.downToUp,
            ),
          );
        },
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    //target: LatLng(37.42796133580664, -122.085749655962),
    target: LatLng(19.395749849, -99.176549),
    //target: LatLng(lat, ln),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(19.395749849, -99.176549),
      //target: LatLng(lat,lng),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();

  final double _zoom = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        initialCameraPosition: MapPage._kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToNewYork,
        child: Icon(Icons.local_pharmacy, color: Colors.white),
      ),
    );
  }

  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('newyork'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(
            title: 'New York',
            snippet: 'Welcome!',
          ),
        ),
      );
    });
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),

        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getApplicationDocumentsDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.

            Navigator.push(
              context,
              PageTransition(
                child: DisplayPictureScreen(imagePath: path),
                type: PageTransitionType.downToUp,
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'The Picture',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                height: 200.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 23.0,
                  vertical: 32.0,
                ),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Ficha(
              data: 'Medicina',
              datated: '1',
            ),
            SizedBox(
              height: 20.0,
            ),
            Ficha(
              data: 'Frecuencia',
              datated: '8',
            ),
            SizedBox(
              height: 20.0,
            ),
            Ficha(
              data: 'Fecha inicio',
              datated: '23/Jun/2019',
            ),
            SizedBox(
              height: 20.0,
            ),
            Ficha(
              data: 'Fecha término',
              datated: '27/Jun/2019',
            ),
            SizedBox(
              height: 20.0,
            ),
            Ficha(
              data: 'Descripción',
              datated: 'Cura',
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     child: Container(),
                //     type: PageTransitionType.downToUp,
                //   ),
                // );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 64),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Ok',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontFamily: "aBeeZee",
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Ficha extends StatelessWidget {
  final String data;
  final String datated;

  Ficha({this.data, this.datated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            offset: Offset(0, 10),
            blurRadius: 30,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              data,
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ),
          datated != null
              ? Container(
                  child: Text(
                    datated,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String medicina;
  final String descripcion;
  final String hora;

  MyCard({this.medicina, this.descripcion, this.hora});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.deepOrangeAccent,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.mode_comment,
                color: Colors.deepOrangeAccent,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    medicina,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    descripcion,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hora,
                style: TextStyle(
                  fontSize: 26.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
