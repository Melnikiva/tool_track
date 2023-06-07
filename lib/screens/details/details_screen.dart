import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_track/data_models/asset_data.dart';
import 'package:tool_track/components/square_network_image.dart';
import 'package:tool_track/components/tag.dart';
import 'package:tool_track/constants.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = 'details';

  DetailsScreen({
    super.key,
    required this.assetData,
  }) {
    print(assetData.toJson());
  }
  final AssetData assetData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          assetData.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Stack(
              children: [
                SquareNetworkImage(imageUrl: assetData.imageUrl),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Tag(status: assetData.tag),
                ),
              ],
            ),
            SizedBox(height: kFormElemetsGap),
            PaddingCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assetData.title,
                    style:
                        TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: kFormElemetsGap / 2),
                  Text(
                    assetData.description,
                    style: kTextStyleDefault,
                  ),
                ],
              ),
            ),
            SizedBox(height: kFormElemetsGap / 2),
            DetailsCard(
              title: 'Owner',
              icon: Icons.person_outline,
              text: ' ${assetData.creator}',
            ),
            SizedBox(height: kFormElemetsGap / 2),
            DetailsCard(
              title: 'Group',
              icon: Icons.group_outlined,
              text:
                  assetData.group.isEmpty ? 'Personal group' : assetData.group,
            ),
            SizedBox(
              height: kFormElemetsGap / 2,
            ),
            MarkeredMap(coordinates: assetData.coordinates),
            SizedBox(
              height: kFormElemetsGap / 2,
            ),
            DetailsCard(
              title: 'Last accessed',
              icon: Icons.schedule,
              text: assetData.getTimeString(),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    super.key,
    required this.title,
    required this.icon,
    this.text = '',
  });

  final String title;
  final IconData icon;
  final String text;

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
          Text(
            text,
            style: kTextStyleDefault,
          ),
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
