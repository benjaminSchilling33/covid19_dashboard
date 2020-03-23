# covid19_dashboard

A flutter application showing the latest statistics about Covid19


## How to build

Build the app using `flutter build apk --split-per-abi`.

## How to build for release

Increment the `flutterVersionCode` and `flutterVersionName` in `android/app/build.gradle` as well as `version` in pubspec.yaml

Required `key.properties` in `./android/`.

Content:

```
storePassword=<Keystore Password>
keyPassword=<Key Password>
keyAlias=<Alias>
storeFile=<Location of the Keystore>
```

## How to add the Syncfusion License

Create a class called `MyLicenseRegisterer` extending `SyncfusionLicenseRegisterer`.
Make sure to pass your license key to the constructor of `SyncfusionLicenseRegisterer` via `super`.

```dart
import 'package:covid19_dashboard/utilities/syncfusion_license_registerer.dart';

class MyLicenseRegisterer extends SyncfusionLicenseRegisterer {
  MyLicenseRegisterer()
      : super('<License Key>');
}
```

Additionally you have to store copy the Manifest template files to the correct location.

```
AndroidManifest.xml.template-main to android/app/src/main/AndroidManifest.xml
AndroidManifest.xml.template-debug to android/app/src/debug/AndroidManifest.xml
AndroidManifest.xml.template-profile to android/app/src/profile/AndroidManifest.xml
```
And don't forget to put your Google Maps API key to the value of the following entry:

`<meta-data android:name="com.google.android.geo.API_KEY" android:value=""/>`

## License
SPDX-License-Identifier: GPL-2.0-only

The full version of the license can be found in LICENSE.

## Copyright
Copyright (C) 2020 Benjamin Schilling
Design by Fabian Schilling