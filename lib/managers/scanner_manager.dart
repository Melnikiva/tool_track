import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:tool_track/constants.dart';

class ScannerManager {
  Future<String> scanRfid() async {
    if (!await isAvailable()) {
      EasyLoading.showInfo('NFC Not Supported!');
      return kNfcUnavailable;
    }
    final Duration scanDuration = Duration(seconds: 5);
    try {
      EasyLoading.show(
        status: 'Waiting for scan',
        maskType: EasyLoadingMaskType.black,
      );
      final NFCTag tag = await FlutterNfcKit.poll(
        timeout: scanDuration,
      );
      EasyLoading.showSuccess('RFID Found!');
      return tag.id;
    } catch (e) {
      print(e);
      EasyLoading.showError('RFID Not Found');
    }
    return '';
  }

  Future<bool> isAvailable() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      return false;
    }
    return true;
  }
}
