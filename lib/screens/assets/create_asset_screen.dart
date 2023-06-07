import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/bordered_container.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tool_track/managers/account_manager.dart';
import 'package:tool_track/managers/location_manager.dart';
import 'package:tool_track/managers/scanner_manager.dart';
import 'package:tool_track/managers/storage_manager.dart';
import '../../components/card_icon_button.dart';

const double kImageSize = 100.0;

class CreateAssetScreen extends StatefulWidget {
  CreateAssetScreen({super.key});

  static const route = 'create_asset';
  final StorageManager _storageManager = StorageManager();
  final LocationManager _locationManager = LocationManager();
  final ScannerManager _scannerManager = ScannerManager();

  @override
  State<CreateAssetScreen> createState() => _CreateAssetScreenState();
}

class _CreateAssetScreenState extends State<CreateAssetScreen> {
  // final _controller = Completer<GoogleMapController>();
  final MapPickerController mapPickerController = MapPickerController();
  GoogleMapController? googleMapController;

  AssetData assetData = AssetData();
  String locationResolved = 'Pick Location';
  String identifierResolved = 'Attach Identifier';

  @override
  void initState() {
    super.initState();
    assetData.creator = AccountManager().getFullName();
    initPosition();
  }

  void resolveCoordinates() async {
    // Delay to wait for map initialization
    await Future.delayed(Duration(milliseconds: 500));
    if (assetData.coordinates.latitude == 0) return;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      assetData.coordinates.latitude,
      assetData.coordinates.longitude,
    );
    setState(() {
      locationResolved =
          '${placemarks.first.thoroughfare} ${placemarks.first.subThoroughfare}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}';
    });
  }

  void initPosition() async {
    final Position pos = await widget._locationManager.getCurrentPosition();
    setState(() {
      assetData.coordinates = LatLng(pos.latitude, pos.longitude);
      googleMapController
          ?.moveCamera(CameraUpdate.newLatLng(assetData.coordinates));
    });

    resolveCoordinates();
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

  String? standartValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Asset'),
      ),
      body: Form(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
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
                    onChanged: (value) {
                      assetData.title = value;
                    },
                    validator: standartValidator,
                  ),
                  SizedBox(
                    height: kFormElemetsGap,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                    ),
                    onChanged: (value) {
                      assetData.description = value;
                    },
                  ),
                  SizedBox(
                    height: kFormElemetsGap * 2,
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: assetData.creator,
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
                        value: 0,
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
                                target: assetData.coordinates,
                                zoom: 16.5,
                              ),
                              onMapCreated: (controller) {
                                googleMapController = controller;
                              },
                              onCameraMoveStarted: () {
                                mapPickerController.mapMoving!();
                              },
                              onCameraMove: (cameraPosition) {
                                this.assetData.coordinates =
                                    cameraPosition.target;
                              },
                              onCameraIdle: () async {
                                // notify map stopped moving
                                mapPickerController.mapFinishedMoving!();
                                //get address name from camera position
                                resolveCoordinates();
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
                      hintText: "You can define your custom ID",
                      counterText: "Auto generated ID: ${assetData.id}",
                    ),
                    onChanged: (value) {
                      assetData.id = value;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: kFormElemetsGap,
                  ),
                  BorderedContainer(
                    borderColor: identifierResolved == kNfcUnavailable
                        ? kAlertColor
                        : Colors.black38,
                    child: Row(
                      children: [
                        Text(
                          identifierResolved,
                          style: kTextStyleDefault,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        CardIconButton(
                          onPressed: () async {
                            final rfidData =
                                await widget._scannerManager.scanRfid();
                            setState(() {
                              identifierResolved = rfidData;
                            });
                            assetData.rfid = rfidData;
                          },
                          icon: Icons.sensors,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kFormElemetsGap,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                bottom: 16.0,
                top: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              child: RectButton(
                text: "CREATE",
                onPressed: () async {
                  EasyLoading.show();
                  await widget._storageManager.newAsset(assetData: assetData);
                  EasyLoading.dismiss();
                  Navigator.pop(context);
                },
                color: kSecondaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
