import 'package:covid19_dashboard/model/covid19_data.dart';
import 'package:covid19_dashboard/utilities/data_fetcher.dart';
import 'package:covid19_dashboard/widgets/country_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ThemeWrapper());
}

class ThemeWrapper extends StatelessWidget {
  ThemeWrapper({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return new MaterialApp(
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

  Widget build(BuildContext context) {
    Future<Covid19Data> data = DataSetFetcher.fetchDataSet();
    return FutureBuilder<Covid19Data>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new MaterialApp(
            theme: Theme.of(context),
            title: 'Covid19Dashboard',
            home: CountryList(
              data: snapshot.data,
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
    );
  }
}
