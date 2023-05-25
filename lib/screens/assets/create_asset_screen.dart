import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:tool_track/asset_data.dart';
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
  AssetData assetData = AssetData();
  LatLng position = LatLng(0, 0);
  MapPickerController mapPickerController = MapPickerController();
  GoogleMapController? googleMapController;

  String locationResolved = 'Attach Initial Location';

  @override
  void initState() {
    super.initState();
    initPosition();
  }

  void resoleCoordinates() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    setState(() {
      locationResolved =
          '${placemarks.first.name}, ${placemarks.first.administrativeArea}';
    });
  }

  void initPosition() async {
    final Position pos = await widget._locationManager.getCurrentPosition();
    setState(() {
      position = LatLng(pos.latitude, pos.longitude);
      googleMapController?.moveCamera(CameraUpdate.newLatLng(position));
    });

    resoleCoordinates();
  }

  void uploadImage({required bool fromGallery}) async {
    ImagePicker imagePicker = ImagePicker();
    ImageSource imageSource =
        fromGallery ? ImageSource.gallery : ImageSource.camera;
    XFile? image = await imagePicker.pickImage(source: imageSource);

    String? uploadUrl = await widget._storageManager.uploadImage(image);
    if (uploadUrl == null) return;
    setState(() {
      assetData.imageUrl = uploadUrl;
    });
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
                        assetData.imageUrl == ''
                            ? Icon(
                                Icons.image_outlined,
                                color: Colors.black45,
                                size: kImageSize,
                              )
                            : Image.network(
                                assetData.imageUrl,
                                width: kImageSize,
                                height: kImageSize,
                                fit: BoxFit.cover,
                              ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          'Attach Image',
                          style: kTextStyleDefault,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        CardIconButton(
                          onPressed: () {
                            uploadImage(fromGallery: true);
                          },
                          icon: Icons.attach_file,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        CardIconButton(
                          onPressed: () {
                            uploadImage(fromGallery: false);
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
                    ExpansionPanelList.radio(
                      initialOpenPanelValue: 1,
                      children: [
                        ExpansionPanelRadio(
                          value: 1,
                          headerBuilder: ((context, isExpanded) {
                            return ListTile(
                              contentPadding: EdgeInsets.all(8.0),
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
                                      style: kTextStyleDefault,
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
                                initialCameraPosition: CameraPosition(
                                  target: position,
                                  zoom: 16.5,
                                ),
                                onMapCreated: (controller) {
                                  _controller.complete(controller);
                                  googleMapController = controller;
                                  print('MAP CREATED');
                                  print(position);
                                },
                                onCameraMoveStarted: () {
                                  mapPickerController.mapMoving!();
                                },
                                onCameraMove: (cameraPosition) {
                                  this.position = cameraPosition.target;
                                },
                                onCameraIdle: () async {
                                  // notify map stopped moving
                                  mapPickerController.mapFinishedMoving!();
                                  //get address name from camera position
                                  resoleCoordinates();
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kFormElemetsGap * 2,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Custom ID",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Define your custom ID",
                        counterText: "Auto generated ID is: ${assetData.id}",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: kFormElemetsGap,
                    ),
                    BorderedContainer(
                      child: Row(
                        children: [
                          Text(
                            'Attach Identificator',
                            style: kTextStyleDefault,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          CardIconButton(
                            onPressed: () {},
                            icon: Icons.qr_code_2,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CardIconButton(
                            onPressed: () {},
                            icon: Icons.sensors,
                          ),
                        ],
                      ),
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

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;

  const BorderedContainer(
      {super.key,
      required this.child,
      this.borderColor = Colors.black38,
      this.borderWidth = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: this.borderWidth, color: this.borderColor),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: this.child,
    );
  }
}
