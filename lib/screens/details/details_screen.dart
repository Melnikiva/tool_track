import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/components/rect_button.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/square_network_image.dart';
import 'package:tool_track/components/tag.dart';
import 'package:tool_track/constants.dart';
import 'package:tool_track/managers/storage_manager.dart';

class DetailsScreen extends StatefulWidget {
  static const String route = 'details';

  DetailsScreen({
    super.key,
    required this.assetData,
  }) {
    print(assetData.toJson());
  }
  final AssetData assetData;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isEdited = false;
  List groups = [];
  late AssetData _assetData;

  @override
  void initState() {
    super.initState();
    getGroups();
    _assetData = widget.assetData;
  }

  void getGroups() async {
    groups = await StorageManager().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.assetData.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isEdited) StorageManager().updateAsset(_assetData);
                isEdited = !isEdited;
              });
            },
            icon: !isEdited ? Icon(Icons.edit) : Icon(Icons.done),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Stack(
              children: [
                SquareNetworkImage(imageUrl: widget.assetData.imageUrl),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Tag(status: widget.assetData.tag),
                ),
              ],
            ),
            SizedBox(height: kFormElemetsGap),
            PaddingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !isEdited
                      ? Text(
                          widget.assetData.title,
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.bold),
                        )
                      : TextFormField(
                          maxLength: 30,
                          initialValue: _assetData.title,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Name",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            _assetData.title = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                        ),
                  SizedBox(height: kFormElemetsGap / 2),
                  !isEdited
                      ? Text(
                          widget.assetData.description,
                          style: kTextStyleDefault,
                        )
                      : TextFormField(
                          maxLines: 3,
                          initialValue: _assetData.description,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Description",
                          ),
                          onChanged: (value) {
                            _assetData.description = value;
                          },
                        ),
                ],
              ),
            ),
            SizedBox(height: kFormElemetsGap / 2),
            DetailsCard(
              title: 'Owner',
              icon: Icons.person_outline,
              text: ' ${widget.assetData.creator}',
            ),
            SizedBox(height: kFormElemetsGap / 2),
            !isEdited
                ? DetailsCard(
                    title: 'Group',
                    icon: Icons.group_outlined,
                    text: widget.assetData.group.isEmpty
                        ? 'Personal group'
                        : widget.assetData.group,
                  )
                : DetailsCard(
                    title: 'Group',
                    icon: Icons.group_outlined,
                    child: DropdownButton(
                      value: _assetData.group,
                      onChanged: (value) {
                        setState(() {
                          _assetData.group = value!;
                        });
                      },
                      items:
                          groups.map<DropdownMenuItem<String>>((groupsTitle) {
                        return DropdownMenuItem<String>(
                          value: groupsTitle,
                          child: Text(groupsTitle),
                        );
                      }).toList(),
                    ),
                  ),
            SizedBox(
              height: kFormElemetsGap / 2,
            ),
            MarkeredMap(coordinates: widget.assetData.coordinates),
            SizedBox(
              height: kFormElemetsGap / 2,
            ),
            DetailsCard(
              title: 'Last accessed',
              icon: Icons.schedule,
              text: widget.assetData.getTimeString(),
            ),
            SizedBox(
              height: kFormElemetsGap / 2,
            ),
            !isEdited
                ? SizedBox(
                    height: 1,
                  )
                : RectButton(
                    text: "DELETE",
                    onPressed: () {
                      StorageManager().removeAsset(widget.assetData.id);
                      Navigator.pop(context);
                    },
                    color: Colors.red.shade400,
                  )
          ],
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  DetailsCard({
    super.key,
    required this.title,
    required this.icon,
    this.text = '',
    this.child = null,
  });

  final String title;
  final IconData icon;
  final String text;
  late final Widget? child;

  @override
  Widget build(BuildContext context) {
    return PaddingCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                title,
                style: kStrongTextStyle,
              ),
            ],
          ),
          !text.isEmpty
              ? Text(
                  text,
                  style: kTextStyleDefault,
                )
              : child!,
        ],
      ),
    );
  }
}

class MarkeredMap extends StatefulWidget {
  MarkeredMap({
    super.key,
    required this.coordinates,
  });

  final LatLng coordinates;

  @override
  State<MarkeredMap> createState() => _MarkeredMapState();
}

class _MarkeredMapState extends State<MarkeredMap> {
  String latestLocation = 'Latest location';

  void getCurrentLocation() async {
    await Future.delayed(Duration(milliseconds: 500)); // lag delay
    List<Placemark> placemarks = await placemarkFromCoordinates(
      widget.coordinates.latitude,
      widget.coordinates.longitude,
    );
    setState(() {
      latestLocation =
          '${placemarks.first.thoroughfare} ${placemarks.first.subThoroughfare}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}';
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 0,
      children: [
        ExpansionPanelRadio(
          value: 0,
          headerBuilder: ((context, isExpanded) {
            return ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  SizedBox(
                    width: 240.0,
                    child: Text(
                      latestLocation,
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
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.coordinates,
                zoom: 16.5,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('Latest location'),
                  position: widget.coordinates,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange),
                ),
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
      ],
    );
  }
}

class PaddingCard extends StatelessWidget {
  const PaddingCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: this.child,
      ),
    );
  }
}
