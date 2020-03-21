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
Make sure to pass your license key to the

```dart
import 'package:covid19_dashboard/utilities/syncfusion_license_registerer.dart';

class MyLicenseRegisterer extends SyncfusionLicenseRegisterer {
  MyLicenseRegisterer()
      : super('<License Key>');
}
```




