# covid19_dashboard

A flutter application showing the latest statistics about Covid19

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


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


