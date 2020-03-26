/*
covid19_dashboard
This is the dart file containing the main function and the app entry point.
SPDX-License-Identifier: GPL-2.0-only
Copyright (C) 2020 Benjamin Schilling
*/

import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/utilities/data_provider.dart';
import 'package:covid19_dashboard/utilities/my_license_registerer.dart';
import 'package:covid19_dashboard/utilities/syncfusion_license_registerer.dart';
import 'package:covid19_dashboard/widgets/country_list.dart';
import 'package:covid19_dashboard/widgets/covid_map.dart';
import 'package:covid19_dashboard/widgets/who_advices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  final SyncfusionLicenseRegisterer licenseRegisterer = MyLicenseRegisterer();
  licenseRegisterer.registerLicense();
  SyncfusionLicense.validateLicense();
  runApp(ProviderWrapper());
}

class ProviderWrapper extends StatelessWidget {
  ProviderWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataProvider(), child: ThemeWrapper());
  }
}

class ThemeWrapper extends StatelessWidget {
  ThemeWrapper({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Color(0xff000000),
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(),
        ),
        primaryColorDark: Color(0xff000000),
        indicatorColor: Color(0xFFFE5000),
        accentColor: Color(0xFFFE5000),
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          body1: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          body2: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          subtitle: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          subhead: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          display1: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          caption: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          overline: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          headline: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
        ),
        cardColor: Color(0xFF3b3b3b),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xFF4d4d4d),
          actionTextColor: Color(0xFFFE50000),
          contentTextStyle: TextStyle(
            color: Color(0xFFD0D0CE),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 30,
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1a1a1a),
          iconTheme: IconThemeData(
            color: Color(0xFFFE5000),
          ),
        ),
        buttonColor: Color(0xFFFE5000),
        iconTheme: IconThemeData(
          color: Color(0xFFFE5000),
        ),
        toggleableActiveColor: Color(0xFFFE5000),
      ),
      home: Covid19DashboardApp(key: key),
    );
  }
}

class Covid19DashboardApp extends StatelessWidget {
  Covid19DashboardApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) => FutureBuilder<Covid19Data>(
        future: dataProvider.futureCovidData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.fetchingFailed) {
              dataProvider.initializeProvider(snapshot.data, context);
              return MaterialApp(
                theme: Theme.of(context),
                title: 'Covid-19 Dashboard',
                home: Scaffold(
                  appBar: AppBar(
                    title: Text('Covid-19 Dashboard'),
                  ),
                  body: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: RaisedButton(
                            child: Text('Country List'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountryListState(
                                      dataProvider: dataProvider),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: RaisedButton(
                            child: Text('Map'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CovidMap(dataProvider: dataProvider),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: RaisedButton(
                            child: Text('Recommendations by WHO'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WHORecommendations(),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: FaIcon(
                                    FontAwesomeIcons.twitterSquare,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('#FlattenTheCurve'),
                              ],
                            ),
                            onPressed: () async {
                              if (await canLaunch(
                                  'https://twitter.com/hashtag/flattenthecurve')) {
                                await launch(
                                    'https://twitter.com/hashtag/flattenthecurve');
                              } else {
                                throw 'Could not launch https://twitter.com/hashtag/flattenthecurve';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return new MaterialApp(
                theme: Theme.of(context),
                title: 'Covid19Dashboard',
                home: SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Covid-19 Dashboard'),
                    ),
                    backgroundColor: Color(0xff000000),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text('Fetching failed'),
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          } else {
            return new MaterialApp(
              theme: Theme.of(context),
              title: 'Covid19Dashboard',
              home: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Covid-19 Dashboard'),
                  ),
                  backgroundColor: Color(0xff000000),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Container(
                          child: Text('Fetching data'),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
