/*
covid19_dashboard
This is the dart file containing the SyncfusionLicenseRegisterer class wrapping the Syncfusion License register function.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:syncfusion_flutter_core/core.dart';

abstract class SyncfusionLicenseRegisterer {
  String licenseKey;

  SyncfusionLicenseRegisterer(this.licenseKey);

  registerLicense() {
    SyncfusionLicense.registerLicense(licenseKey);
  }
}
