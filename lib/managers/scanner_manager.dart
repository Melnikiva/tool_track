import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:tool_track/constants.dart';

class ScannerManager {
  Future<String> scanRfid() async {
    if (!await isAvailable()) {
      return kNfcUnavailable;
    }

    String serial = '';
    var tag = await FlutterNfcKit.poll(
      timeout: Duration(seconds: 10),
    );
    print(jsonEncode(tag));
    return serial;
  }

  Future<bool> isAvailable() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    print(availability.toString());
    if (availability != NFCAvailability.available) {
      return false;
    }
    return true;
  }
}
