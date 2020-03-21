import 'package:syncfusion_flutter_core/core.dart';

abstract class SyncfusionLicenseRegisterer {
  String licenseKey;

  SyncfusionLicenseRegisterer(this.licenseKey);

  registerLicense() {
    SyncfusionLicense.registerLicense(licenseKey);
  }
}
