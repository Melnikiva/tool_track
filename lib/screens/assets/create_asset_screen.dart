import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tool_track/managers/account_manager.dart';
import 'package:tool_track/managers/location_manager.dart';
import 'package:tool_track/managers/storage_manager.dart';
import 'components/card_icon_button.dart';

const double kImageSize = 100.0;

class CreateAssetScreen extends StatefulWidget {
  CreateAssetScreen({super.key});

  static const route = 'create_asset';
  final StorageManager _storageManager = StorageManager();
  final LocationManager _locationManager = LocationManager();

  @override
  State<CreateAssetScreen> createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  final _controller = Completer<GoogleMapController>();
  String imageUrl = '';
  LatLng position = LatLng(0, 0);
  MapPickerController mapPickerController = MapPickerController();

  String locationResolved = 'Attach Initial Location';

  @override
  void initState() {
    super.initState();
    initPosition();
  }

  void initPosition() async {
    final Position pos = await widget._locationManager.getCurrentPosition();
    setState(() {
      position = LatLng(pos.latitude, pos.longitude);
    });
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        imageUrl == ''
                            ? Icon(
                                Icons.image_outlined,
                                color: Colors.black45,
                                size: kImageSize,
                              )
                            : Image.network(
                                imageUrl,
                                width: kImageSize,
                                height: kImageSize,
                                fit: BoxFit.cover,
                              ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          'Attach Image',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        CardIconButton(
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            String? uploadUrl =
                                await widget._storageManager.uploadImage(image);

                            if (uploadUrl == null) return;
                            print(uploadUrl);
                            setState(() {
                              imageUrl = uploadUrl;
                            });
                          },
                          icon: Icons.attach_file,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CardIconButton(
                          onPressed: () {
                            ImagePicker imagePicker = ImagePicker();
                            imagePicker.pickImage(source: ImageSource.camera);
                          },
                          icon: Icons.camera_alt_outlined,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kFormElemetsGap * 2,
                    ),
                    TextFormField(
                      maxLength: 30,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Write here",
                      ),
                    ),
                    SizedBox(
                      height: kFormElemetsGap,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Description",
                      ),
                    ),
                    SizedBox(
                      height: kFormElemetsGap * 2,
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: AccountManager().getFullName(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Creator",
                      ),
                    ),
                    SizedBox(
                      height: kFormElemetsGap * 2,
                    ),
                    ExpansionPanelList(
                      children: [
                        ExpansionPanel(
                          isExpanded: true,
                          headerBuilder: ((context, isExpanded) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  SizedBox(
                                    width: 250.0,
                                    child: Text(
                                      locationResolved,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          body: Container(
                            height: 300.0,
                            width: double.infinity,
                            child: MapPicker(
                              mapPickerController: mapPickerController,
                              iconWidget: Icon(
                                Icons.location_on,
                                color: kSecondaryColor,
                                size: 50.0,
                              ),
                              child: GoogleMap(
                                myLocationEnabled: true,
                                zoomControlsEnabled: false,
                                // onMapCreated: (GoogleMapController controller) {
                                //   _controller.complete(controller);
                                // },
                                initialCameraPosition: CameraPosition(
                                  target: position,
                                  zoom: 16.5,
                                ),
                                onMapCreated: (controller) async {
                                  await controller.moveCamera(
                                      CameraUpdate.newLatLng(position));
                                },
                                onCameraMoveStarted: () {
                                  // notify map is moving
                                  mapPickerController.mapMoving!();
                                },
                                onCameraMove: (cameraPosition) {
                                  this.position = cameraPosition.target;
                                  // setState(() {

                                  // });
                                },
                                onCameraIdle: () async {
                                  // notify map stopped moving
                                  mapPickerController.mapFinishedMoving!();
                                  //get address name from camera position
                                  List<Placemark> placemarks =
                                      await placemarkFromCoordinates(
                                    position.latitude,
                                    position.longitude,
                                  );

                                  // update the ui with the address
                                  setState(() {
                                    locationResolved =
                                        '${placemarks.first.name}, ${placemarks.first.administrativeArea}';
                                  });
                                },
                                gestureRecognizers: Set()
                                  ..add(
                                    Factory<EagerGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: kFormElemetsGap,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
                child: RectButton(
                  text: "CREATE",
                  onPressed: () {},
                  color: kSecondaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
